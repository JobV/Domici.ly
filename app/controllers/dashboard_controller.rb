class DashboardController < ApplicationController
  before_filter :authenticate_user!

  def index
    current_user.hoa ? @activities = PublicActivity::Activity.where(hoa_id: current_user.hoa.id).order('created_at desc').limit(10) : @activities = []
    @post = Post.new user: current_user
  end
end
