module Cron::Tasks::LibraryEntries
  extend self

  class Mappings
    JSON.mapping({
      data: Array(Users)
    })
    class Users
      JSON.mapping({
        id: String,
        attributes: Attributes
      })
      class Attributes
        JSON.mapping({
          name: String,
          updatedAt: String,
          createdAt: String
        })
      end
    end
  end

  def response(user_id, offset = 0)
    query = HTTP::Params.build do |param|
      param.add "filter[user_id]", user_id.to_s
      param.add "filter[kind]", "anime"
      param.add "fields[users]", "name,updatedAt,createdAt"
      param.add "page[limit]", LIMIT_LIBRARY.to_s
      param.add "page[offset]", offset.to_s
    end

    Hibari::Kitsu.get("users", query)
  end

  # TODO: Loop through all users in DB and collect their library entries

  def cron_runner
    # For coursework, limit to 40 users (2 requests of 20)
    # For production, refactor to keep looping until links->next no
    # longer exists
    0.upto(1) do |i|
      data = Mappings.from_json(response i*LIMIT)

      data.data.each do |u|
        # Deleted users are assigned to one -10 ID we want to ignore
        if u.id == "-10"
          next
        end

        user = Repo.get(Repo::User, u.id.to_i) || Repo::User.new

        if user.id
          user.name = u.attributes.name
          user.updated_at =u.attributes.updatedAt
          Repo.update(user)
        else
          user.id = u.id
          user.name = u.attributes.name
          user.updated_at =u.attributes.updatedAt
          user.created_at = u.attributes.createdAt
          Repo.insert(user)
        end
      end
    end
  end
end
