module Hibari::Routes
  get "/" do |env|
    user = Repo::User.new
    user.name = "123"

    changeset = Repo::User.changeset(user)
    puts changeset.valid?

    Repo.insert(user)
    puts changeset.errors
  end
end
