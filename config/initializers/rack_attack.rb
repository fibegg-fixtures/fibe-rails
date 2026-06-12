# frozen_string_literal: true

redis_url = ENV.fetch("REDIS_URL", "redis://localhost:6379/1")
Rack::Attack.cache.store = ActiveSupport::Cache::RedisCacheStore.new(url: redis_url)

unless ENV["ENABLE_RACK_ATTACK"] == "1"
  Rack::Attack.enabled = false if Rails.env.test? || Rails.env.development?
end

DEFAULT_UI_RPH = ENV.fetch("RACK_ATTACK_UI_RPH", 5000).to_i
DEFAULT_API_RPH = ENV.fetch("RACK_ATTACK_API_RPH", 5000).to_i

Rack::Attack.safelist("health-check") do |req|
  req.path == "/up"
end

Rack::Attack.throttle("ui/ip", limit: DEFAULT_UI_RPH, period: 3600) do |req|
  next if req.path.start_with?("/api/", "/api")

  req.ip
end

Rack::Attack.throttle("api/ip", limit: DEFAULT_API_RPH, period: 3600) do |req|
  next unless req.path.start_with?("/api/")

  req.ip
end

Rack::Attack.throttled_responder = lambda { |req|
  matched = req.env["rack.attack.match_data"] || {}
  retry_after = (matched[:period] || 60) - (matched[:epoch_time] % (matched[:period] || 60))

  headers = {
    "Content-Type" => "application/json",
    "Retry-After" => retry_after.to_s,
  }
  body = { error: { code: "RATE_LIMITED", message: "Rate limit exceeded. Retry after #{retry_after} seconds." } }.to_json
  [429, headers, [body]]
}
