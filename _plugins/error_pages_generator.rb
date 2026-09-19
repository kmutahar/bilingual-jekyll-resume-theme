# frozen_string_literal: true

module BilingualJekyllResumeTheme
  # Programmatically synthesizes standard HTTP error pages (404, 403, 500)
  # into site.pages if they are not already defined by the site.
  class ErrorPagesGenerator < Jekyll::Generator
    safe true
    priority :low

    ERROR_PAGES = {
      "404" => {
        "file" => "404.html",
        "title" => "404 - Page Not Found / الصفحة غير موجودة"
      },
      "403" => {
        "file" => "403.html",
        "title" => "403 - Access Forbidden / الوصول محظور"
      },
      "500" => {
        "file" => "500.html",
        "title" => "500 - Internal Server Error / خطأ داخلي في الخادم"
      }
    }.freeze

    def generate(site)
      ERROR_PAGES.each do |code, info|
        filename = info["file"]
        # Skip if page already exists in site.pages or in site source files
        next if site.pages.any? { |p| p.name == filename || p.url == "/#{filename}" }
        next if File.exist?(site.in_source_dir(filename))
        next if File.exist?(site.in_source_dir("_pages", filename))

        page = Jekyll::PageWithoutAFile.new(site, site.source, "", filename)
        page.content = ""
        page.data["layout"] = "error"
        page.data["code"] = code
        page.data["title"] = info["title"]
        page.data["permalink"] = "/#{filename}"
        page.data["sitemap"] = false

        site.pages << page
      end
    end
  end
end
