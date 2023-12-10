module UserHelper
  def avatar_url(current_user)
    return current_user.avatar if current_user.avatar.attached?
    "profile"
  end
end
