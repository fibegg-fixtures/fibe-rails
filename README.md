# fibe-rails

Minimal Rails 8 starter for [fibe](https://github.com/fibegg/fibe) **Charge Playgrounds**. Optimized for fast cold starts — small Docker image, no AnyCable / PgBouncer / LocalStack, Hotwire livereload, Phlex views, Packwerk-organized business logic, iframe-safe cookies.

## Stack

| Layer | Choice |
|---|---|
| Framework | Rails 8.1 (edge) + Ruby 4.0 |
| Views | Phlex (no ERB) |
| Frontend | Hotwire (Turbo + Stimulus) + Basecoat UI + Tailwind CSS |
| Database | PostgreSQL (direct, no pgbouncer) |
| Cache + Jobs + ActionCable | Redis + Sidekiq + Sidekiq-Cron |
| Object storage | Minio (S3-compatible, port 9000) |
| Boundaries | Packwerk |
| Tests | RSpec + Capybara |
| Dev reload | hotwire-livereload (in-process) |

## Quick start

```bash
git clone https://github.com/fibegg-fixtures/fibe-rails
cd fibe-rails
docker compose up
```

The `setup` service runs `bin/setup --skip-server` (bundle + db prepare), then `app` boots foreman (`web` + `css` + `jobs`). If Active Storage tables exist, setup also ensures the Minio bucket. Visit <http://localhost:3000>.

### Local (without Docker)

Needs Ruby 4.0+, Postgres, Redis, and Minio running locally.

```bash
bin/setup       # bundle + db + start dev server
bin/check-fast  # lint + tests in parallel
```

## Iframe embedding

This app is built to be iframed by fibe.gg. Defaults in `env.example` are dev-friendly (HTTP localhost); for production set:

```
COOKIE_SAMESITE=none
COOKIE_SECURE=true
CSP_MODE=enforce
FRAME_ANCESTORS=https://fibe.gg https://*.fibe.gg
CORS_ALLOWED_ORIGINS=https://fibe.gg,https://app.fibe.gg
```

`partitioned: true` is applied automatically when `COOKIE_SAMESITE=none` + `COOKIE_SECURE=true` (Chrome CHIPS).

## Packwerk

See `packs/example/` for the template. Toggle `enforce_dependencies` / `enforce_privacy` in `package.yml` when you're ready for boundary checks. `bin/packwerk check` runs the analysis.

## Layout

```
app/
  views/             Phlex view classes (Views::Layouts::Application, Views::Home::Index, ...)
  controllers/       Thin Rails controllers that render Phlex
  assets/tailwind/   Tailwind input file + vendored Basecoat CSS
  javascript/        Turbo, Stimulus, app entrypoint
bin/
  setup, dev, check, check-fast, packwerk, jobs, ...
config/
  application.rb     forgery_protection_origin_check=false + env-driven CSP
  initializers/
    session_store.rb iframe-safe SameSite + CHIPS Partitioned cookies
    cors.rb          rack-cors, env-driven origins
    sidekiq.rb       Sidekiq + sidekiq-cron (loads config/recurring.yml)
docker-compose.yml   postgres + redis + minio + setup + app
Dockerfile           single multi-stage, no AnyCable / Chromium / Thruster
packs/example/       sample Packwerk pack
```

## UI

Basecoat UI is the default component layer. Use Basecoat classes like `btn`, `card`, `badge`, `input`, `kbd`, and `tabs` first, then Tailwind utilities for layout and small adjustments.

Basecoat is vendored so Charge does not need Node or CDN access at runtime. The current version is recorded in `vendor/basecoat/VERSION`.

```bash
bin/update-basecoat 0.3.11
bin/rails tailwindcss:build
bin/check-fast
```

The updater writes `vendor/stylesheets/basecoat.css` and `vendor/javascript/basecoat.js`; `config/importmap.rb` pins the JavaScript as `basecoat`.
These small browser assets are tracked. Local dependency/cache directories such as `vendor/bundle`, `vendor/cache`, and `vendor/ruby` stay ignored and are excluded from Docker build context.
