require "kemal"
require "sentry-run"
require "json"
require "./repo/*" # Database connections
require "./hibari/*"
require "./json_api/*"
require "./kitsu/*"

# Kemal configuration
Kemal.config.port = 2222
serve_static false
gzip = true

# Use sentry to live-reload files during development if key not set
# Else, start the Kemal server as normal
unless ENV.has_key? "KEMAL_ENV"
  Sentry.run Sentry.config(
    process_name: "API",
    build_command: "crystal",
    run_command: "./api",
    build_args: [ "build", "src/api.cr", "-o", "./api"],
    should_build: true
  ) do
    Kemal.run
  end
else
  Kemal.run
end
