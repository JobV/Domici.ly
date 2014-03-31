module ApplicationHelper
  def admin?
    current_user.admin if current_user
  end

  def moderator?
    current_user.has_role? :moderator, current_user.hoa if current_user
  end

  def owner?(resource)
    current_user.id == resource.user_id
  end

  def format_date(date)
    return 'Vandaag' if date.today?
    return 'Gisteren' if (date - 1.day).today?
    return date.strftime("%d-%m-%Y")
  end

  def format_time(time)
    return time_ago_in_words time
  end
end
