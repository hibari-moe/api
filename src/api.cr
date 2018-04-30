require "kemal"
require "sentry-run"
require "json"
require "./repo/*" # Database connections
require "./hibari/*"
require "./json_api/*"
require "./kitsu/*"
require "./routes/*"
require "./errors"

# Live Reload Config
process = Sentry.config(
  process_name: "API",
  build_command: "crystal",
  run_command: "./api",
  build_args: [ "build", "src/api.cr", "-o", "./api"],
  should_build: true
)

# Kemal Config
# Kemal.config.port = 3001
serve_static false
gzip = true

module Hibari
  extend Hibari::Errors
  extend Hibari::Routes

  if ENV.has_key? "KEMAL_ENV"
    Kemal.run
  else
    Sentry.run process do
      Kemal.run
    end
  end
end
