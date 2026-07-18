# frozen_string_literal: true

module Views
  module Layouts
    class Application < Views::Base
      def view_template(&block)
        doctype
        html(lang: "en") do
          head do
            title { "Fibe Rails Playground — Poll Sync" }
            meta(name: "viewport", content: "width=device-width,initial-scale=1")
            link(rel: "icon", href: "data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 64 64'%3E%3Crect width='64' height='64' rx='12' fill='%23171717'/%3E%3Cpath d='M16 50V14h34v9H27v9h19v9H27v9H16Z' fill='white'/%3E%3C/svg%3E")
            csrf_meta_tags
            csp_meta_tag
            stylesheet_link_tag("tailwind", "data-turbo-track": "reload")
            javascript_importmap_tags
          end
          body(class: "min-h-screen bg-background text-foreground antialiased", &block)
        end
      end
    end
  end
end
