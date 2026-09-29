# frozen_string_literal: true

require "minitest/autorun"

# Every relative Markdown link and #anchor in the repository's tracked docs must resolve, so a moved
# page or renamed heading cannot silently leave a dead link behind. External URLs are not fetched.
class DocLinksTest < Minitest::Test
  ROOT = File.expand_path("..", __dir__)
  LINK = /\]\(([^)\s]+)(?:\s+"[^"]*")?\)/
  EXTERNAL = /\A(?:https?:|mailto:|tel:)/
  FENCE = "```"

  def test_relative_links_and_anchors_resolve
    files = markdown_files
    refute_empty files, "no tracked Markdown files found (is this a git checkout?)"
    broken = files.flat_map { |file| broken_links(file) }
    assert_empty broken, "Broken documentation links:\n#{broken.join("\n")}"
  end

  def test_slugify_matches_github_anchors
    assert_equal "3-languages", slugify("3. Languages")
    assert_equal "8-_profile-pagescss", slugify("8. `_profile-page.scss`")
    assert_equal "wcag-22-accessibility--high-contrast-standards", slugify("WCAG 2.2 Accessibility & High-Contrast Standards")
  end

  private

  # Tracked Markdown only, so local scratch notes never fail the suite; demo/ is a separate repository.
  def markdown_files
    files = Dir.chdir(ROOT) { `git ls-files -z -- '*.md'`.split("\0") }
    files.select { |file| File.file?(File.join(ROOT, file)) && !file.start_with?("demo/") }
  end

  def broken_links(file)
    prose_lines(File.join(ROOT, file)).each_with_index.flat_map do |line, index|
      line.scan(LINK).flatten.filter_map do |target|
        problem = link_problem(file, target)
        "#{file}:#{index + 1}: #{target} (#{problem})" if problem
      end
    end
  end

  def link_problem(file, target)
    return if target.match?(EXTERNAL)

    path, anchor = target.split("#", 2)
    full = File.expand_path(path.to_s.empty? ? file : File.join(File.dirname(file), path), ROOT)
    return "missing file" unless File.exist?(full)
    return unless anchor && full.end_with?(".md")

    "missing anchor" unless anchors(full).include?(anchor)
  end

  # The file's lines with fenced code blocks blanked out, so example code is never mistaken for links.
  def prose_lines(path)
    fenced = false
    File.readlines(path, chomp: true, encoding: "UTF-8").map do |line|
      fence_line = line.lstrip.start_with?(FENCE)
      fenced = !fenced if fence_line
      fence_line || fenced ? "" : line
    end
  end

  def anchors(path)
    @anchors ||= {}
    @anchors[path] ||= begin
      seen = Hash.new(0)
      slugs = prose_lines(path).filter_map { |line| line[/\A\#{1,6}\s+(.*)/, 1] }.map do |heading|
        slug = slugify(heading)
        count = seen[slug]
        seen[slug] += 1
        count.zero? ? slug : "#{slug}-#{count}"
      end
      slugs + File.read(path, encoding: "UTF-8").scan(/(?:id|name)="([^"]+)"/).flatten
    end
  end

  # GitHub's heading-to-anchor rule: drop markup and punctuation, lowercase, spaces to hyphens.
  def slugify(heading)
    heading.strip.gsub(/\[([^\]]*)\]\([^)]*\)/, '\1').delete("`*~").downcase.gsub(/[^\p{Word}\- ]/, "").tr(" ", "-")
  end
end
