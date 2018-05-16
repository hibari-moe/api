module Cron::Tasks::LibraryEntries
  extend self

  class Mappings
    JSON.mapping({
      data:     Array(LibraryEntries),
      included: Array(Anime)?,
      links:    Links,
    })

    class LibraryEntries
      JSON.mapping({
        id:            String,
        attributes:    Attributes,
        relationships: Relationships,
      })

      class Attributes
        JSON.mapping({
          status:       String,
          progress:     Int32?,
          ratingTwenty: Int32?,
          createdAt:    String,
          updatedAt:    String,
        })
      end

      class Relationships
        JSON.mapping({
          media: Media,
        })

        class Media
          JSON.mapping({
            data: MediaData,
          })

          class MediaData
            JSON.mapping({
              id: String,
            })
          end
        end
      end
    end

    class Anime
      JSON.mapping({
        id:         String,
        type:       String,
        attributes: Attributes,
      })

      class Attributes
        JSON.mapping({
          createdAt: String,
          updatedAt: String,
          status:    String,
          startDate: String?,
        })
      end
    end

    class Links
      JSON.mapping({
        next: String?,
      })
    end

    # Included is not included if there are no relationships, so
    # create an empty array to avoid dealing with Nil
    def included
      @included ||= Array(Anime).new
    end
  end

  def fetch(user_id, offset = 0)
    query = HTTP::Params.build do |p|
      p.add "filter[user_id]", user_id.to_s
      p.add "filter[kind]", "anime"
      p.add "fields[library-entries]", "createdAt,updatedAt,status,progress,ratingTwenty,media"
      p.add "fields[anime]", "createdAt,updatedAt,status,startDate"
      p.add "include", "media"
      p.add "page[limit]", LIMIT_LIBRARY.to_s
      p.add "page[offset]", offset.to_s
    end

    Hibari::Kitsu.get "library-entries", query
  end

  def library_entries(user_id, offset = 0)
    entries = Mappings.from_json(fetch user_id.to_s, offset*LIMIT_LIBRARY)

    # Add or update anime associated with library entries
    entries.included.each do |data|
      Helper.create_anime(data) unless data.type != "anime"
    end

    # Add or update library entries
    entries.data.each do |data|
      Helper.create_library_entries data, user_id
    end

    # If links->next exists, then there is another page of library
    # entries to fetch. If missing (i.e Nil) then we're on the last
    # page and can continue to the next user
    if entries.links.next
      p "# Getting next page" if DEV
      next_page = offset += 1
      library_entries user_id, next_page
    end
  end

  def cron_runner
    query = Repo::Query.select(["id"])
    users = Repo.all Repo::User, query

    users.each do |user|
      p "## Running for user #{user.id}" if DEV
      library_entries user.id
      p "## Finished for user #{user.id}" if DEV
    end
  end
end
