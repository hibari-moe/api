module Hibari::Routes
  get "/users" do |env|
    query = Repo::Query.order_by("users.id DESC")
    users = Repo.all Repo::User, query
    # users = Repo.all Repo::User, query, preload: [:anime_library_entries]

    JSON.build do |json|
      json.array do
        users.as(Array).each do |user|
          json.object do
            json.field "id", user.id
            json.field "name", user.name
          end
        end
      end
    end
  end

  get "/users/:id" do |env|
    user = Repo.get Repo::User, env.params.url["id"]

    unless user.nil?
      user.to_json
    else
      halt env, status_code: 404, response: Hibari::JsonAPI.error(404, "Not Found", "User does not exist")
    end
  end
end

# module Hibari::Routes
#  get "/users" do |env|
#    query = Repo::Query.order_by("users.name DESC")
#    users = Repo.all(Repo::User, query, preload: [:anime_library_entries])
#
#    string = JSON.build do |json|
#      json.array do
#        users.as(Array).each do |user|
#          json.object do
#            json.field "id", user.id
#            json.field "name", user.name
#
#            library_entries = users[0].anime_library_entries.as(Array)
#            json.field "library_entries", library_entries.as(Array) unless library_entries.nil?
#          end
#        end
#      end
#    end
#  end
# end
