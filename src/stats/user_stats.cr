module Stats
  extend self

  def user_stats(user_id)
    # Get library entries associated with the user
    query = Repo::Query
      .select(["rating"])
      .where(user_id: user_id)
      .where("rating IS NOT NULL")
    entries = Repo
      .all(Repo::AnimeLibraryEntry, query)
      .map { |entry| entry.rating! }

    stats = {
      "total"              => entries.size,
      "mean"               => entries.mean,
      "median"             => entries.median,
      "mode"               => entries.mode,
      "variance"           => entries.variance,
      "stddev"             => entries.stddev,
      "relative_stddev"    => entries.relative_stddev,
      "rating_frequencies" => entries.frequencies,
    }
  end
end
