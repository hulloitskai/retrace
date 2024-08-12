# typed: true
# frozen_string_literal: true

require "sorbet-runtime"

module Browsing
  extend T::Sig

  # == Accessors
  sig { returns(T::Boolean) }
  def self.headless?
    !ENV["BROWSING_HEADLESS"].falsy?
  end
end
