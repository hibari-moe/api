module Cron::Tasks::AnimeStats
  extend self

  def create_anime_stats(anime_id)
    # Get library entries associated with the anime
    query = Repo::Query
      .select(["rating"])
      .where(anime_id: anime_id)
      .where("rating IS NOT NULL")
    entries = Repo
      .all(Repo::AnimeLibraryEntry, query)
      .map { |entry| entry.rating! }

    # Ignore anime with no ratings
    return if entries.size == 0

    anime_ratings = Repo
      .get(Repo::AnimeRating, anime_id) || Repo::AnimeRating.new

    timestamp = Time.now.to_s "%Y-%m-%dT%H:%M.%LZ"

    anime_ratings.total = entries.size
    anime_ratings.mean = entries.mean
    anime_ratings.median = entries.median
    anime_ratings.mode = entries.mode
    anime_ratings.variance = entries.variance
    anime_ratings.stddev = entries.stddev
    anime_ratings.relative_stddev = entries.relative_stddev
    anime_ratings.updated_at = timestamp
  end

  def cron_runner
    query = Repo::Query.select(["id"])
    anime = Repo.all Repo::Anime, query

    anime.each do |a|
      # p "## Running for anime #{a.id}" if DEV
      create_anime_stats a.id
      # p "## Finished for user #{a.id}" if DEV
    end
  end
end
