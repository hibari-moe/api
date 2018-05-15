module Cron::Tasks::LibraryEntries
  extend self

  enum Status
    Current = 1
    Planned
    Completed
    On_Hold
    Dropped
  end

  enum AiringStatus
    TBA = 1
    Unreleased
    Upcoming
    Current
    Finished
  end

  class Mappings
    JSON.mapping({
      data: Array(LibraryEntries),
      included: Array(Anime),
      links: Links
    })
    class LibraryEntries
      JSON.mapping({
        id: String,
        attributes: Attributes,
        relationships: Relationships
      })
      class Attributes
        JSON.mapping({
          status: String,
          progress: Int32?,
          ratingTwenty: Int32?,
          createdAt: String,
          updatedAt: String
        })
      end
      class Relationships
        JSON.mapping({
          media: Media
        })
        class Media
          JSON.mapping({
            data: MediaData
          })
          class MediaData
            JSON.mapping({
              id: String
            })
          end
        end
      end
    end
    class Anime
      JSON.mapping({
        id: String,
        attributes: Attributes
      })
      class Attributes
        JSON.mapping({
          createdAt: String,
          updatedAt: String,
          status: String,
          startDate: String
        })
      end
    end
    class Links
      JSON.mapping({
        next: String?
      })
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

    Hibari::Kitsu.get("library-entries", query)
  end

  def create_user_anime_library_entry(user_id, entry_id)
    p "Set user anime library entry #{user_id}, #{entry_id}"

    uale = Repo.get_by(
      Repo::UserAnimeLibraryEntry,
      user_id: user_id,
      anime_library_entry_id: entry_id
    ) || Repo::UserAnimeLibraryEntry.new

    #2018-03-20T16:31:12.000Z
    timestamp = Time.now.to_s("%Y-%m-%dT%H:%M.%LZ")
    uale.updated_at = timestamp

    p entry_id

    unless uale.user_id && uale.anime_library_entry_id
      uale.user_id = user_id
      uale.anime_library_entry_id = entry_id
      uale.created_at = timestamp
      p "Added anime library entry"
      Repo.insert(uale)
    else
      p "Updated anime library entry"
      Repo.update(uale)
    end
  end

  def create_anime(anime_id)
    p "Set anime #{anime_id}"

    anime = Repo.get(Repo::Anime, anime_id) || Repo::Anime.new

    timestamp = Time.now.to_s("%Y-%m-%dT%H:%M.%LZ")
    anime.updated_at = timestamp
    anime.created_at = timestamp

    #if attributes
    #  anime.status = AiringStatus.parse(attributes.status)
    #  anime.start_date = attributes.startDate
    #  anime.updated_at = attributes.updatedAt
    #  anime.created_at = attributes.createdAt
    #end

    if anime.id
      p "update #{anime_id}"
      Repo.update(anime)
    else
      p "insert #{anime_id}"
      anime.id = anime_id
      Repo.insert(anime)
    end
  end

  def populate_anime(anime_id, attributes)
  end

  # TODO: Loop through all users in DB and collect their library entries

  def library_entries(user_id, offset = 0)
    entries = Mappings.from_json(fetch user_id.to_s, offset*LIMIT_LIBRARY)

    entries.included.each do |r|
      # p r
      # create_anime anime_id
    end

    entries.data.each do |e|
      entry_id = e.id.to_i
      anime_id = e.relationships.media.data.id.to_i
      attr = e.attributes

      entry = Repo.get(Repo::AnimeLibraryEntry, entry_id) || Repo::AnimeLibraryEntry.new

      entry.rating = attr.ratingTwenty
      entry.status = Status.parse(attr.status).value
      entry.updated_at = attr.updatedAt
      entry.created_at = attr.createdAt
      entry.anime_id = anime_id

      create_user_anime_library_entry user_id, entry_id

      p "existing id: #{entry.id}"

      if entry.id
        p "update #{entry_id}"
        Repo.update(entry)
      else
        p "insert #{entry_id}"
        p "user #{user_id}"
        entry.id = entry_id
        p "new id: #{entry.id}"

        changeset = Repo::AnimeLibraryEntry.changeset(entry)
        p changeset.changes

        Repo.insert(entry)
        p "done"
      end
    end
  end

  def cron_runner
    query = Repo::Query.select(["id"])
    users = Repo.all(Repo::User, query)

    users.each do |u|
      library_entries user_id: u.id
      # p u.id.to_s
    end
  end
end
