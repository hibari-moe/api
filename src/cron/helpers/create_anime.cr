module Cron::Helper
  def create_anime(data)
    anime_id = data.id.to_i
    attr = data.attributes
    anime = Repo.get(Repo::Anime, anime_id) || Repo::Anime.new

    timestamp = Time.now.to_s "%Y-%m-%dT%H:%M.%LZ"
    anime.updated_at = timestamp
    anime.created_at = timestamp

    if attr
      anime.status = AiringStatus.parse(attr.status).value
      anime.start_date = attr.startDate
      anime.updated_at = attr.updatedAt
      anime.created_at = attr.createdAt
    end

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
