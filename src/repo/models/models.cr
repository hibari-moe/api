module Repo
  class User < Crecto::Model
    set_created_at_field nil
    set_updated_at_field nil

    schema "users" do
      field :updated_at, String
      field :created_at, String
      field :name, String
      has_many :anime_library_entries, AnimeLibraryEntry
    end
  end

  class AnimeLibraryEntry < Crecto::Model
    set_created_at_field nil
    set_updated_at_field nil

    schema "anime_library_entries" do
      field :updated_at, String
      field :created_at, String
      field :status, Int64
      field :rating, Int64
      field :progress, Int64
      belongs_to :user, User
      belongs_to :anime, Anime
    end
  end

  class Anime < Crecto::Model
    set_created_at_field nil
    set_updated_at_field nil

    schema "anime" do
      field :updated_at, String
      field :created_at, String
      field :status, Int64
      field :episodes, Int64
      field :start_date, String
    end
  end
end
