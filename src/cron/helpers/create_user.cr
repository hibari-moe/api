module Cron::Helper
  def create_user(data)
    user_id = data.id.to_i
    attr = data.attributes

    # Deleted users are assigned to one -10 ID we want to ignore
    return if user_id == -10

    user = Repo.get(Repo::User, user_id) || Repo::User.new

    user.name = attr.name
    user.updated_at = attr.updatedAt
    user.created_at = attr.createdAt

    if user.id
      p "update user #{user_id}" if DEV
      Repo.update user
    else
      p "insert user #{user_id}" if DEV
      user.id = user_id
      Repo.insert user
    end
  end
end
