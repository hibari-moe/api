module Repo
  class User < Crecto::Model
    schema "users" do
      field :name, String
    end
  end
end
