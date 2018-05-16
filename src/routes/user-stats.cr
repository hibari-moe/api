module Hibari::Routes
  get "/user-stats/:id" do |env|
    user_id = env.params.url["id"].to_i
    user = Repo.get(Repo::User, user_id).as(Repo::User)

    if user.nil?
      halt(
        env,
        status_code: 404,
        response: Hibari::JsonAPI.error(404, "Not Found", "User does not exist")
      )
    end

    stats = Stats.user_stats user_id

    JSON.build do |json|
      json.object do
        json.field "data" do
          json.object do
            JsonAPI.field json, "id", user.id
            JsonAPI.field json, "type", "usersStats"
            json.field "attributes" do
              json.object do
                stats.each do |key, value|
                  value = value.round(2) unless value.nil?
                  JsonAPI.field json, key, value
                end
              end
            end
          end
        end
      end
    end
  end
end
