class DashboardController < ApplicationController
  before_filter :authenticate_user!

  def index
    @activities = PublicActivity::Activity.order('created_at desc')
    @post = Post.new user: current_user
  end
end
