# typed: true
# frozen_string_literal: true

require "sorbet-runtime"

module Browserbase
  extend T::Sig

  sig { returns(T.nilable(String)) }
  def self.api_key
    ENV["BROWSERBASE_API_KEY"]
  end

  sig { returns(String) }
  def self.api_key!
    api_key or raise "Browserbase API key not set"
  end

  sig { returns(String) }
  def self.browser_cdp_url
    @browser_cdp_url ||= scoped do
      url = Addressable::URI.parse("wss://connect.browserbase.com")
      url.query_values = { "apiKey" => api_key! }
      url.to_s
    end
  end
end
