# packs/example

A starter Packwerk pack. Use it as the template for new bounded contexts.

Inside a pack you can have the usual Rails directories — `app/services`,
`app/models`, `app/views`, `app/components`, `app/jobs`, etc. Rails autoloads
each `packs/<name>/app/<dir>` automatically because of `package_paths` in
`packwerk.yml`.

Toggle `enforce_dependencies` and `enforce_privacy` in `package.yml` once
you're ready for boundary checks. Run `bin/packwerk check` to see violations.

## Files

- `app/services/example/hello_service.rb` — minimal service object that
  Phlex views or controllers can call.
