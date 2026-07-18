# frozen_string_literal: true

module Views
  module Home
    class Index < Views::Base
      def view_template
        render(Views::Layouts::Application.new) do
          main(class: "mx-auto flex min-h-screen w-full max-w-4xl flex-col justify-center gap-6 p-6 sm:p-8") do
            header(class: "space-y-3") do
              div(class: "flex flex-wrap items-center gap-2") do
                span(class: "badge") { "Rails 8.1" }
                span(class: "badge-secondary") { "Basecoat UI" }
                span(class: "badge-outline") { "Hotwire" }
              end
              h1(class: "text-3xl font-semibold tracking-tight sm:text-4xl") { "Fibe Rails Playground — Poll Sync" }
              p(class: "max-w-2xl text-muted-foreground") do
                plain("Edit ")
                kbd(class: "kbd") { "app/views/home/index.rb" }
                plain(" and save. Hotwire livereload refreshes this page automatically.")
              end
            end

            div(class: "card") do
              header do
                h2 { "What's wired up" }
                p { "A compact Rails starter for fast Charge launches and simple agent edits." }
              end
              section do
                ul(class: "grid gap-2 text-sm text-muted-foreground sm:grid-cols-2") do
                  li { "Rails 8.1 + Ruby 4.0 + Hotwire" }
                  li { "Phlex views, no ERB" }
                  li { "Basecoat UI + Tailwind CSS" }
                  li { "PostgreSQL + Redis + Sidekiq" }
                  li { "Packwerk boundaries in packs/example" }
                  li { "Iframe-safe cookies + CSP + CORS knobs" }
                end
              end
              footer(class: "flex flex-wrap gap-2") do
                a(class: "btn", href: "https://basecoatui.com/components/button/", target: "_blank", rel: "noreferrer") do
                  "Basecoat components"
                end
                a(class: "btn-outline", href: "https://guides.rubyonrails.org/", target: "_blank", rel: "noreferrer") do
                  "Rails guides"
                end
              end
            end

            div(class: "grid gap-4 sm:grid-cols-3") do
              [
                ["Views", "Phlex classes in app/views"],
                ["Jobs", "Sidekiq and recurring jobs ready"],
                ["Storage", "Active Storage ready when you add migrations"],
              ].each do |title, body|
                div(class: "card") do
                  header do
                    h2(class: "text-base") { title }
                    p { body }
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
