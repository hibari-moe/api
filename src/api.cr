require "http/client"
require "uri"
require "kemal"
require "json"
require "./api/*"

serve_static false

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

  Kemal.run
end

include Hibari
