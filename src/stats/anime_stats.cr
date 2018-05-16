module Stats
  def anime_stats(anime_id)
    # Get library entries associated with the anime
    query = Repo::Query
      .select(["rating"])
      .where(anime_id: anime_id)
      .where("rating IS NOT NULL")
    entries = Repo
      .all(Repo::AnimeLibraryEntry, query)
      .map { |entry| entry.rating! }

    stats = {
      "total" => entries.size,
      "mean" => entries.mean,
      "median" => entries.median,
      "mode" => entries.mode,
      "variance" => entries.variance,
      "stddev" => entries.stddev,
      "relative_stddev" => entries.relative_stddev,
      "rating_frequencies" => entries.frequencies
    }
  end
end
