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
end
