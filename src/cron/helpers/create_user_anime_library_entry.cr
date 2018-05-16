module Cron::Helper
  def create_user_anime_library_entry(user_id, entry_id)
    uale = Repo.get_by(
      Repo::UserAnimeLibraryEntry,
      user_id: user_id,
      anime_library_entry_id: entry_id
    ) || Repo::UserAnimeLibraryEntry.new

    # 2018-03-20T16:31:12.000Z
    timestamp = Time.now.to_s "%Y-%m-%dT%H:%M.%LZ"
    uale.updated_at = timestamp

    unless uale.user_id && uale.anime_library_entry_id
      uale.user_id = user_id
      uale.anime_library_entry_id = entry_id
      uale.created_at = timestamp

      Repo.insert uale
    else
      Repo.update uale
    end
  end
end
