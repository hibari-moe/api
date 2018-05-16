module Cron::Helper
  def create_library_entries(data, user_id)
    entry_id = data.id.to_i
    anime_id = data.relationships.media.data.id.to_i
    attr = data.attributes

    # Get entry from DB or create a new placeholder
    entry = Repo.get(Repo::AnimeLibraryEntry, entry_id) || Repo::AnimeLibraryEntry.new

    # Add or update attributes
    entry.rating = attr.ratingTwenty
    entry.status = Status.parse(attr.status).value
    entry.updated_at = attr.updatedAt
    entry.created_at = attr.createdAt
    entry.anime_id = anime_id
    entry.user_id = user_id

    if entry.id
      p "update entry #{entry_id}" if DEV
      Repo.update entry
    else
      p "insert entry #{entry_id}" if DEV
      entry.id = entry_id
      Repo.insert entry
    end
  end
end
