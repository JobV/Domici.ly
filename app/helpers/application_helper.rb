module ApplicationHelper
  def admin?
    current_user.admin if current_user
  end
end
