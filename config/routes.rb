# frozen_string_literal: true

require "sidekiq/web"

unless Rails.env.development?
  Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
    ActiveSupport::SecurityUtils.secure_compare(user, ENV.fetch("SIDEKIQ_USER", "admin")) &
      ActiveSupport::SecurityUtils.secure_compare(password, ENV.fetch("SIDEKIQ_PASSWORD", "admin"))
  end
end

Rails.application.routes.draw do
  get("up" => "rails/health#show", as: :rails_health_check)

  mount(Sidekiq::Web => "/sidekiq")
  mount(MaintenanceTasks::Engine => "/maintenance_tasks")

  root("home#index")
end
