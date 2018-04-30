module Repo
  class Manga < Crecto::Model
    schema "manga" do
      field :start_date, Time
    end
  end
end
