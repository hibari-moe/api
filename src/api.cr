require "http/client"
require "uri"
require "kemal"
require "sentry-run"
require "json"
require "./api/*"

serve_static false
gzip true

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

  if ENV.has_key?("CRYSTAL_ENV")
    Kemal.run
  else
    process = Sentry.config(
      process_name: "API",
      build_command: "crystal",
      run_command: "./api"
    )
    Sentry.run(process) do
      Kemal.run
    end
  end
end

include Hibari
