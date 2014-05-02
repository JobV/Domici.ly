module ApplicationHelper
  def admin?
    current_user.admin if current_user
  end

  def moderator?(user)
    user.has_role? :moderator, user.hoa if user
  end

  def maintenance?(user)
    user.has_role? :maintenance, user.hoa if user
  end

  def owner?(resource)
    current_user.id == resource.user_id
  end

  def owner_or_moderator?(resource)
    owner?(resource) || moderator?
  end

  def pretty_role(user)
    return 'Bestuurder' if moderator?(user)
    return 'Huismeester' if maintenance?(user)
    'Eigenaar'
  end

  def format_date(date)
    return 'Vandaag' if date.today?
    return 'Gisteren' if (date - 1.day).today?
    return l date, format: :short
  end

  def format_event_date(date)
    l date, format: :shorter
  end

  def format_event_date_time(date)
    l date, format: :shorter_with_time
  end

  def format_event_time(date)
    date.strftime("%R")
  end

  def format_time(time)
    return time_ago_in_words time
  end

  def link_to_activity_owner(activity)
    link_to((activity.owner.full_name if activity.owner), user_path(activity.owner))
  end

  def gravatar_url(user)
    hash = Digest::MD5.hexdigest(user.email)
    "http://www.gravatar.com/avatar/#{hash}?d=retro"
  end

  def big_gravatar(user,size)
    hash = Digest::MD5.hexdigest(user.email)
    "http://www.gravatar.com/avatar/#{hash}?d=retro&size=#{size}"
  end
end
