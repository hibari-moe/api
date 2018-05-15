module Cron::Tasks::Users
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

  def fetch_users(offset = 0)
    query = HTTP::Params.build do |p|
      p.add "sort", "id"
      p.add "fields[users]", "name,updatedAt,createdAt"
      p.add "page[limit]", LIMIT.to_s
      p.add "page[offset]", offset.to_s
    end

    Hibari::Kitsu.get("users", query)
  end

  def cron_runner
    # For coursework, limit to 40 users (2 requests of 20)
    # For production, refactor to keep looping until links->next no
    # longer exists
    0.upto(1) do |i|
      data = Mappings.from_json(fetch_users i*LIMIT)

      data.data.each do |u|
        user_id = u.id.to_i

        # Deleted users are assigned to one -10 ID we want to ignore
        if user_id == -10
          next
        end

        user = Repo.get(Repo::User, user_id) || Repo::User.new

        if user.id
          user.name = u.attributes.name
          user.updated_at =u.attributes.updatedAt
          Repo.update(user)
        else
          user.id = user_id
          user.name = u.attributes.name
          user.updated_at =u.attributes.updatedAt
          user.created_at = u.attributes.createdAt
          Repo.insert(user)
        end
      end
    end
  end
end
