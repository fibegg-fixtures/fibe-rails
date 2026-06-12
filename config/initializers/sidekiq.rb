# frozen_string_literal: true

require "sidekiq"
require "sidekiq-cron"

redis_url = ENV.fetch("REDIS_URL", "redis://localhost:6379/1")
redis_config = { url: redis_url }
redis_config[:ssl_params] = { verify_mode: OpenSSL::SSL::VERIFY_NONE } if redis_url.start_with?("rediss://")

Sidekiq.configure_server do |config|
  config.redis = redis_config

  schedule_file = "config/recurring.yml"

  if File.exist?(schedule_file)
    schedule = YAML.load_file(schedule_file, aliases: true)[Rails.env]
    if schedule.present?
      cron_hash = schedule.transform_values do |job|
        {
          "cron" => job["schedule"],
          "class" => job["class"],
          "queue" => job["queue"] || "default",
          "active_job" => true,
        }
      end

      begin
        Sidekiq::Cron::Job.load_from_hash(cron_hash)
      rescue RedisClient::CannotConnectError => e
        Rails.logger.warn("Sidekiq cron: Redis unavailable, skipping schedule load (#{e.message})")
      end
    end
  end
end

Sidekiq.configure_client do |config|
  config.redis = redis_config
end
