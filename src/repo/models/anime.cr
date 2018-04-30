module Repo
  class Anime < Crecto::Model
    schema "anime" do
      field :start_date, Time
      # has_many :anime_library_entries, AnimeLibraryEntry
    end
  end
end
