# frozen_string_literal: true

namespace :assets do
  desc "Verify Charge-critical CSS and JavaScript assets are resolvable"
  task verify: :environment do
    required_assets = [
      "tailwind.css",
      "application.js",
      "turbo.min.js",
      "stimulus.min.js",
      "stimulus-loading.js",
      "basecoat.js",
      "controllers/application.js",
      "controllers/index.js",
    ]

    missing = required_assets.reject do |logical_path|
      Rails.application.assets.load_path.find(logical_path).present?
    end

    if missing.any?
      abort("Missing required asset(s): #{missing.join(", ")}")
    end

    puts "Verified #{required_assets.length} assets."
  end
end
