module Repo
  class AnimeLibraryEntry < Crecto::Model
    schema "anime_library_entries" do
      field :status, Int32
      field :rating, Int32
      # has_one :anime_id, Anime
    end
  end
end
