module ApplicationHelper
  def admin?
    current_user.admin if current_user
  end

  def format_date(date)
    return 'Vandaag' if date.today?
    return 'Gisteren' if (date - 1.day).today?
    return date.strftime("%d-%m-%Y")
  end
end
