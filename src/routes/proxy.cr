module Hibari::Routes
  get "/kitsu/:model" do |env|
    model = env.params.url["model"]
    query = env.params.query

    Hibari::Kitsu.get(model, query).to_json
  end
end
