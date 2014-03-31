module AlertsHelper
  def new_alert?(alert)
    alert.state_list.empty?
  end

  def alert_in_progress?(alert)
    alert.state_list.include?('in progress') unless alert_completed?(alert)
  end

  def alert_completed?(alert)
    alert.state_list.include?('completed') or alert.state_list.include?('complete')
  end
end
