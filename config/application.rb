# frozen_string_literal: true

require_relative "boot"

require "rails"
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_view/railtie"
require "action_cable/engine"

Bundler.require(*Rails.groups)

module FibeRails
  class Application < Rails::Application
    config.load_defaults(8.1)

    config.i18n.available_locales = [:en]
    config.i18n.default_locale = :en

    config.autoload_lib(ignore: ["assets", "tasks"])

    config.generators.system_tests = nil
    config.active_job.queue_adapter = :sidekiq

    config.action_controller.forgery_protection_origin_check = false

    if ENV.fetch("CSP_MODE", "off") != "off"
      ancestors = ENV.fetch("FRAME_ANCESTORS", "*").split(/\s+/).map { |a| a == "*" ? :"*" : a }
      config.content_security_policy do |policy|
        policy.default_src(:self, :https)
        policy.font_src(:self, :https, :data)
        policy.img_src(:self, :https, :data)
        policy.script_src(:self, :https, :unsafe_inline)
        policy.style_src(:self, :https, :unsafe_inline)
        policy.connect_src(:self, :https, :wss, :ws)
        policy.frame_ancestors(*ancestors)
      end
      config.content_security_policy_report_only = ENV["CSP_MODE"] == "report-only"
    end
  end
end
