# frozen_string_literal: true

Rails.application.config.assets.version = "1.0"

Rails.application.config.assets.paths << Rails.root.join("app/assets/builds")
Rails.application.config.assets.paths << Rails.root.join("node_modules")
Rails.application.config.assets.paths << Rails.root.join("vendor/javascript")
Rails.application.config.assets.paths << Rails.root.join("vendor/stylesheets")
