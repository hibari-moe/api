module Cron::Helper
  def create_anime(data)
    anime_id = data.id.to_i
    attr = data.attributes
    anime = Repo.get(Repo::Anime, anime_id) || Repo::Anime.new

    anime.status = AiringStatus.parse(attr.status).value
    anime.start_date = attr.startDate
    anime.episodes = attr.episodeCount
    anime.updated_at = attr.updatedAt
    anime.created_at = attr.createdAt

    if anime.id
      p "update anime #{anime_id}" if DEV
      Repo.update anime
    else
      p "insert anime #{anime_id}" if DEV
      anime.id = anime_id
      Repo.insert anime
    end
  end
end
