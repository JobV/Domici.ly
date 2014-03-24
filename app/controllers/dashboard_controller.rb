class DashboardController < ApplicationController
  before_filter :authenticate_user!

  def index
    Bugsnag.notify 'Someone visited the dashboard'
    @alerts = current_user.hoa ? current_user.hoa.alerts.order(created_at: :desc) : current_user.alerts.order(created_at: :desc)
  end
end
