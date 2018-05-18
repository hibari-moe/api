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
      if ( # Don't update if data hasn't changed
        anime.status === AiringStatus.parse(attr.status).value &&
        anime.start_date === attr.startDate &&
        anime.episodes === attr.episodeCount
      )
       return nil
      end

      p "update anime #{anime_id}" #if DEV
      Repo.update anime
    else # doesn't exist in database
      p "insert anime #{anime_id}" #if DEV
      anime.id = anime_id
      anime.created_at = current_time
      Repo.insert anime
    end

    anime = nil
    return nil
  end
end
