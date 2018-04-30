module Hibari::Routes
  get "/" do |env|
    #user = Repo::User.new
    #user.name = "123"
    #changeset = Repo::User.changeset(user)
    #puts changeset.valid?
    #Repo.insert(user)
    #puts changeset.errors
    query = Repo::QUERY.order_by("users.name DESC")
    Repo.all(Repo::User, query).to_json
  end
end
