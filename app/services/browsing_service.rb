# typed: true
# frozen_string_literal: true

class BrowsingService < ApplicationService
  # == Methods
  sig { params(block: T.proc.params(page: Playwright::Page).void).void }
  def self.open_page(&block)
    Playwright.create(
      playwright_cli_executable_path: "playwright",
    ) do |playwright|
      if Rails.env.development?
        playwright.chromium.launch(headless: Browsing.headless?) do |browser|
          page = browser.new_page
          yield(page)
        end
      else
        browser = playwright.chromium.connect_over_cdp(
          Browserbase.browser_cdp_url,
        )
        default_context = browser.contexts.first!
        page = default_context.pages.first!
        yield(page)
      end
    end
  end
end
