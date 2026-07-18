# frozen_string_literal: true

require "rails_helper"

RSpec.describe("Home") do
  it "renders the Phlex home page" do
    get("/")
    expect(response).to(have_http_status(:ok))
    expect(response.body).to(include("Fibe Rails Playground — Poll Sync"))
    expect(response.body).to(include("\"basecoat\""))
    expect(response.body).to(include("Basecoat UI + Tailwind CSS"))
    expect(response.body).to(include("class=\"card\""))
  end

  it "serves the asset URLs emitted by the layout" do
    get("/")
    expect(response).to(have_http_status(:ok))

    asset_paths = response.body.scan(%r{(?:href|src)="(/assets/[^"]+)"}).flatten.uniq
    expect(asset_paths).to(include(a_string_matching(%r{/assets/tailwind-[^/]+\.css})))
    expect(asset_paths).to(include(a_string_matching(%r{/assets/application-[^/]+\.js})))

    asset_paths.each do |path|
      get(path)
      expect(response).to(have_http_status(:ok), "#{path} returned #{response.status}")
    end
  end
end
