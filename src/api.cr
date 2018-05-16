require "kemal"
require "sentry-run"
require "json"
require "./repo/*" # Database connections
require "./hibari/*"
require "./json_api/*"
require "./kitsu/*"
require "./enum/*"
require "./stats/*"
require "./cron/*"

# True for bin/run
DEV = ENV.has_key?("KEMAL_ENV") && ENV["KEMAL_ENV"] == "development"
# True for bin/spec
TEST = ENV.has_key?("KEMAL_ENV") && ENV["KEMAL_ENV"] == "test"

# Kemal configuration
Kemal.config.port = 2222
serve_static false
gzip = true

# Use sentry to live-reload files during development
if DEV
  Sentry.run Sentry.config(
    process_name: "API",
    build_command: "crystal",
    run_command: "./api",
    build_args: ["build", "src/api.cr", "-o", "./api"],
    should_build: true
  ) do
      Cron.run
      Kemal.run
  end
else
  Cron.run
  Kemal.run
end
