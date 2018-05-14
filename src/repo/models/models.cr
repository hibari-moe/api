module Repo
  class User < Crecto::Model
    set_created_at_field nil
    set_updated_at_field nil

    schema "users" do
      field :updated_at, String
      field :created_at, String
      field :name, String
      has_many :user_anime_library_entries, UserAnimeLibraryEntry
      has_many :anime_library_entries, AnimeLibraryEntry, through: :user_anime_library_entries
    end
  end

  class AnimeLibraryEntry < Crecto::Model
    set_created_at_field nil
    set_updated_at_field nil

    schema "anime_library_entries" do
      field :updated_at, String
      field :created_at, String
      field :status, Int32
      field :rating, Int32
      has_many :user_anime_library_entries, UserAnimeLibraryEntry
    end
  end

  class UserAnimeLibraryEntry < Crecto::Model
    set_created_at_field nil
    set_updated_at_field nil

    schema "user_anime_library_entries", primary_key: false do
      field :updated_at, String
      field :created_at, String
      belongs_to :user, User
      belongs_to :anime_library_entry, AnimeLibraryEntry
    end
  end

  class Anime < Crecto::Model
    set_created_at_field nil
    set_updated_at_field nil

    schema "anime" do
      field :updated_at, String
      field :created_at, String
      field :status, Int32
      field :start_date, Time
      has_one :anime_ratings, AnimeRating
    end
  end

  class AnimeRating < Crecto::Model
    set_created_at_field nil
    set_updated_at_field nil

    schema "anime_ratings" do
      field :updated_at, String
      field :created_at, String
      field :total, Int32
      field :mean, Int32
      field :median, Int32
      field :mode, Int32
      field :variance, Int32
      field :standard_deviation, Int32
      belongs_to :anime, Anime
    end
  end
end
