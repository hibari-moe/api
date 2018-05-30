module Cron::Helper
  def create_anime(data)
    anime_id = data.id.to_i
    attr = data.attributes
    anime = Repo.get(Repo::Anime, anime_id) || Repo::Anime.new

    anime.status = AiringStatus.parse(attr.status).value
    anime.start_date = attr.startDate
    anime.episodes = attr.episodeCount
    anime.updated_at = current_time

    if anime.id # exists in database
      unless ( # Don't update if data hasn't changed
        anime.status === AiringStatus.parse(attr.status).value &&
        anime.start_date === attr.startDate &&
        anime.episodes === attr.episodeCount
      )
        p "Update anime #{anime_id}" #if DEV
        Repo.update anime
      end
    else # doesn't exist in database
      p "Insert anime #{anime_id}" #if DEV
      anime.id = anime_id
      anime.created_at = current_time
      Repo.insert anime
    end

    GC.free(anime.as(Void*))
  end
end
