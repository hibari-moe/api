module Repo
  class AnimeRating < Crecto::Model
    schema "anime_ratings" do
      field :total, Int32
      field :mean, Int32
      field :median, Int32
      field :mode, Int32
      field :variance, Int32
      field :standard_deviation, Int32
    end
  end
end
