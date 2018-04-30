module Repo
  class Category < Crecto::Model
    schema "categories" do
      field :name, String
    end
  end
end
