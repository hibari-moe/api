module Cron::Helper
  def create_user(data)
    user_id = data.id.to_i
    attr = data.attributes

    # Deleted users are assigned to one -10 ID we want to ignore
    return if user_id == -10

    user = Repo.get(Repo::User, user_id) || Repo::User.new

    user.name = attr.name
    user.updated_at = current_time

    if user.id
      return if user.name === attr.name
      p "Update user #{user_id}" # if DEV
      Repo.update user
    else
      p "Insert user #{user_id}" # if DEV
      user.id = user_id
      user.created_at = current_time
      Repo.insert user
    end

    GC.free(user.as(Void*))
  end
end
