# frozen_string_literal: true

require "simplecov" if ENV["COVERAGE_FORMAT"]

if ENV["COVERAGE_FORMAT"]
  SimpleCov.start("rails") do
    add_filter "/spec/"
    add_filter "/config/"
    add_filter "/vendor/"
    formatter SimpleCov::Formatter::HTMLFormatter
  end
end

if ENV["SILENT_TESTS"] == "1"
  $VERBOSE = nil
end

RSpec.configure do |config|
  config.order = :random
  Kernel.srand(config.seed)

  config.expect_with(:rspec) do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with(:rspec) do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end
