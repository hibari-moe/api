module Hibari::Routes
  get "/anime-stats/:id" do |env|
    anime_id = env.params.url["id"].to_i
    anime = Repo.get(Repo::Anime, anime_id).as(Repo::Anime)

    if anime.nil?
      halt(
        env,
        status_code: 404,
        response: Hibari::JsonAPI.error(404, "Not Found", "Anime does not exist")
      )
    end

    stats = Stats.anime_stats anime_id

    JSON.build do |json|
      json.object do
        json.field "data" do
          json.object do
            JsonAPI.field json, "id", anime.id
            JsonAPI.field json, "type", "animeStats"
            json.field "attributes" do
              JsonAPI.attribute_stats json, stats
            end
          end
        end
      end
    end
  end
end
