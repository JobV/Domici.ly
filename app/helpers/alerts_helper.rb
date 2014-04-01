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
end
