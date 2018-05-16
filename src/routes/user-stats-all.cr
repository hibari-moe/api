# module Hibari::Routes
#   get "/user-stats" do |env|
#     query_users = Repo::Query.order_by("users.id DESC")
#     users = Repo.all Repo::User, query_users

#     JSON.build do |json|
#       json.array do
#         users.as(Array).each do |user|
#           json.object do
#             json.field "id", user.id
#             json.field "name", user.name
#           end
#         end
#       end
#     end
#   end
# end
