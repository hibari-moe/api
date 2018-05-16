module Cron::Tasks::Users
  extend self

  struct Mappings
    JSON.mapping({
      data: Array(Users),
    })

    struct Users
      JSON.mapping({
        id:         String,
        attributes: Attributes,
      })

      struct Attributes
        JSON.mapping({
          name:      String,
          updatedAt: String,
          createdAt: String,
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

    Hibari::Kitsu.get "users", query
  end

  def cron_runner
    # For coursework, limit to 100 users (5 requests of 20)
    # For production, refactor to keep looping until links->next no
    # longer exists
    0.upto(5) do |i|
      data = Mappings.from_json(fetch_users i*LIMIT)

      data.data.each do |data|
        Helper.create_user data
      end
    end
  end
end
