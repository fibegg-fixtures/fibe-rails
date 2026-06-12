# frozen_string_literal: true

# Iframe-friendly session cookie configuration.
# - In dev (HTTP localhost): default SameSite=lax, not Secure.
# - In prod (HTTPS, possibly framed by fibe.gg): default SameSite=none + Secure + Partitioned (CHIPS).
# All flags overridable via env vars so playground operators can lock things down.

same_site = ENV.fetch("COOKIE_SAMESITE", Rails.env.development? ? "lax" : "none").to_sym
secure    = ENV.fetch("COOKIE_SECURE", Rails.env.development? ? "false" : "true") == "true"

options = {
  key: "_fibe_rails_session",
  same_site: same_site,
  secure: secure,
  httponly: true,
}

# Chrome's CHIPS — partitioned cookies for cross-site iframes.
# Only meaningful when SameSite=None + Secure.
options[:partitioned] = true if same_site == :none && secure

Rails.application.config.session_store(:cookie_store, **options)
