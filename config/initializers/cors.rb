# frozen_string_literal: true

allowed = ENV.fetch("CORS_ALLOWED_ORIGINS", "*")

Rails.application.config.middleware.insert_before(0, Rack::Cors) do
  allow do
    if allowed.strip == "*"
      origins("*")
      resource("*", headers: :any, methods: [:get, :post, :put, :patch, :delete, :options, :head])
    else
      origins(*allowed.split(",").map(&:strip))
      resource(
        "*",
        headers: :any,
        methods: [:get, :post, :put, :patch, :delete, :options, :head],
        credentials: true,
      )
    end
  end
end
