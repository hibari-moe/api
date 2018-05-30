module Cron::Tasks::Users
  extend self

  struct Mappings
    JSON.mapping({
      data:  Array(Users),
      links: Links,
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

    struct Links
      JSON.mapping({
        next: String?,
      })
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

  def users(page = 0)
    data = Mappings.from_json(fetch_users page*LIMIT)
    data.data.each do |d|
      Helper.create_user data: d
    end

    if data.links.next
      return true
    else
      return false
    end
  end

  def users_init(page = 0)
    has_next_page = true
    next_page = page

    while has_next_page
      has_next_page = users page
      if has_next_page
        p "Getting next page" if DEV
        page += 1
      else
        p "No more pages" if DEV
        break
      end
    end
  end

  def cron_runner
    users_init 1
  end
end
