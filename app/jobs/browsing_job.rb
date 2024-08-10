# typed: true
# frozen_string_literal: true

class BrowsingJob < ApplicationJob
  # == Configuration
  good_job_control_concurrency_with key: BrowsingJob.name, perform_limit: 1
  retry_on GoodJob::ActiveJobExtensions::Concurrency::ConcurrencyExceededError,
           wait: ->(_executions) {
             existing_retries = GoodJob::Job.where(
               concurrency_key: "BrowsingJob",
             ).retried.count
             existing_retries * 5
           },
           attempts: :unlimited
end
