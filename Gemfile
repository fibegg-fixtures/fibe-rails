# frozen_string_literal: true

source "https://rubygems.org"

gem "rails", github: "rails/rails", branch: "main"
gem "propshaft"
gem "pg"
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "tailwindcss-rails"
gem "rails-i18n"

gem "tzinfo-data", platforms: [:windows, :jruby]

gem "bootsnap", require: false

gem "sidekiq"
gem "sidekiq-cron"
gem "redis"

gem "aws-sdk-s3"

gem "phlex-rails"

gem "packwerk"
gem "packwerk-extensions"

gem "rack-cors"
gem "rack-attack"
gem "maintenance_tasks"
gem "ssrf_filter"

gem "hotwire-livereload", "~> 2.1", group: :development

group :development, :test do
  gem "parallel_tests"
  gem "debug", platforms: [:mri, :windows], require: "debug/prelude"

  gem "bundler-audit", require: false
  gem "brakeman", require: false

  gem "rubocop-shopify", require: false
  gem "rubocop-factory_bot", require: false
  gem "rubocop-rails", require: false
  gem "rubocop-rspec", require: false
  gem "rubocop-rspec_rails", require: false
  gem "i18n-tasks", require: false

  gem "flog", require: false
  gem "flay", require: false
  gem "reek", require: false
  gem "skunk", require: false
end

group :development do
  gem "web-console"
  gem "foreman"
end

group :test do
  gem "rspec-rails"
  gem "shoulda-matchers"
  gem "factory_bot_rails"
  gem "faker"
  gem "rspec-parameterized"
  gem "rspec-retry"
  gem "capybara"
  gem "selenium-webdriver"
  gem "simplecov", require: false
  gem "simplecov_json_formatter", require: false
end
