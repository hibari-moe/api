require "kemal"
require "json"

static_headers do |response, filepath, filestat|
  if filepath =~ /\.html$/
    response.headers.add("Access-Control-Allow-Origin", "*")
  end
  response.headers.add("Content-Size", filestat.size.to_s)
end

get "/" do |env|
  env.response.content_type = "application/json"
  { hello: "Hello", world: "World" }.to_json
end

Kemal.run
