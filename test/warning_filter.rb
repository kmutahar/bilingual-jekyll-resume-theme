# frozen_string_literal: true

# Drops only Liquid 4.0.4's frozen-string deprecation (Jekyll 4.4 pins Liquid 4); all other warnings pass through.
module LiquidFrozenWarningFilter
  def warn(msg, **opts)
    return if msg.include?("liquid-4.0.4/") && msg.include?("literal string will be frozen")

    super
  end
end
Warning.singleton_class.prepend(LiquidFrozenWarningFilter)
