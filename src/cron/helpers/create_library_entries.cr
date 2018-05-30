module Cron::Helper
  def create_library_entries(data, user_id)
    entry_id = data.id.to_i
    anime_id = data.relationships.media.data.id.to_i
    attr = data.attributes

    # Get entry from DB or create a new placeholder
    entry = Repo.get(Repo::AnimeLibraryEntry, entry_id) || Repo::AnimeLibraryEntry.new

    # Add or update attributes
    entry.status = CompletionStatus.parse(attr.status).value
    entry.rating = attr.ratingTwenty
    entry.progress = attr.progress
    entry.updated_at = current_time

    if entry.id
      unless ( # Don't update if data hasn't changed
        entry.status === CompletionStatus.parse(attr.status).value &&
        entry.rating === attr.ratingTwenty &&
        entry.progress === attr.progress
      )
        p "Update entry #{entry_id}" # if DEV
        Repo.update entry
      end
    else
      p "Insert entry #{entry_id}" # if DEV
      entry.id = entry_id
      entry.anime_id = anime_id
      entry.user_id = user_id
      entry.created_at = current_time
      Repo.insert entry
    end

    GC.free(entry.as(Void*))
  end
end
