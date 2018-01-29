require "http/client"
require "uri"
require "kemal"
require "sentry-run"
require "json"
require "./api/*"

serve_static false
gzip true

process = Sentry.config(
  process_name: "API",
  build_command: "crystal",
  run_command: "./api",
  build_args: ["build", "src/api.cr", "-o", "api"]
)

module Hibari
  before_all do |env|
    env.response.content_type = CONTENT_TYPE
  end

  get "/" do |env|
    { hello: "Hello", world: "World" }.to_json
  end

  get "/kitsu" do |env|
    kitsu_get("anime").to_json
  end

  get "/user-stats/:id" do |env|
   "Data for user #{env.params.url["id"]}".to_json
  end

  get "/403" do |env|
    halt env, status_code: 403, response: "Forbidden"
  end

  error 404 do |env|
    env.response.content_type = CONTENT_TYPE
    {
      errors: [
        {
          title: "Not Found",
          status: "404"
        }
      ]
    }.to_json
  end

  Sentry.run(process) do
    Kemal.run
  end
end

include Hibari
