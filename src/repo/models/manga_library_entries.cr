module Repo
  class MangaLibraryEntry < Crecto::Model
    schema "manga_library_entries" do
      field :status, Int32
      field :rating, Int32
      # has_one :manga_id, Manga
    end
  end
end
