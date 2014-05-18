class DashboardController < ApplicationController
  before_filter :authenticate_user!

  def index
    current_user.hoa ? @activities = PublicActivity::Activity.where(hoa_id: current_user.hoa.id).includes(:trackable, :owner).order('created_at desc').limit(20) : @activities = []
    @post = Post.new user: current_user

    @unread_alerts = current_user.hoa.alerts.unread_by(current_user)
  end
end
