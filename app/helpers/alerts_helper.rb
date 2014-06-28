module AlertsHelper
  def new_alert?(alert)
    alert.progress == 'new'
  end

  def alert_in_progress?(alert)
    alert.progress == 'in progress'
  end

  def alert_completed?(alert)
    alert.progress == 'completed'
  end

  def progress_name(alert)
    return I18n.t('alert.new') if new_alert?(alert)
    return I18n.t('alert.in_progress') if alert_in_progress?(alert)
    return I18n.t('alert.completed') if alert_completed?(alert)
  end

  def progress_name_from_string(string)
    return I18n.t('alert.new')            if string == 'new'
    return I18n.t('alert.in_progress')    if string == 'in progress'
    return I18n.t('alert.completed')      if string == 'completed'
    return I18n.t('alert.unknown_state')
  end

  def print_assignee(alert, options = {})
    if alert.assignee && options[:short]
      return alert.assignee.first_name
    elsif alert.assignee
      return alert.assignee.full_name
    else
      return t('alert.no_assignee')
    end
  end

  def print_assignee_short(alert)
    print_assignee(alert, short: true)
  end
end
