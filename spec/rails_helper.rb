# frozen_string_literal: true

require "spec_helper"
ENV["RAILS_ENV"] ||= "test"

require_relative "../config/environment"
abort("The Rails environment is running in production mode!") if Rails.env.production?
require "rspec/rails"

Rails.root.glob("spec/support/**/*.rb").sort_by(&:to_s).each { |f| require f }

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort(e.to_s.strip)
end

RSpec.configure do |config|
  config.include(ActiveSupport::Testing::TimeHelpers)

  config.before do |example|
    timeout_seconds = example.metadata[:timeout] || ENV.fetch("EXAMPLE_TIMEOUT", 60).to_i
    pg_timeout_ms = [(timeout_seconds - 2) * 1000, 1000].max
    ActiveRecord::Base.connection.execute("SET LOCAL statement_timeout = '#{pg_timeout_ms}'")
  end

  config.around do |example|
    timeout_seconds = example.metadata[:timeout] || ENV.fetch("EXAMPLE_TIMEOUT", 60).to_i
    Timeout.timeout(timeout_seconds) do
      example.run
    end
  rescue Timeout::Error, Timeout::ExitException
    raise Timeout::Error, "Test timed out after #{timeout_seconds} seconds: #{example.full_description}"
  end

  config.define_derived_metadata(file_path: %r{/spec/system/}) do |metadata|
    metadata[:slow] = true
  end

  config.fixture_paths = [Rails.root.join("spec/fixtures")]
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  config.after(:suite) do
    if defined?(Capybara) && Capybara.current_session.respond_to?(:driver)
      driver = Capybara.current_session.driver
      driver.quit if driver.respond_to?(:quit)
    end
  end
end
