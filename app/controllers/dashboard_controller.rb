class DashboardController < ApplicationController
  before_filter :authenticate_user!

  def index
    @posts = Post.all
    # @posts = current_user.posts
    @alerts = current_user.alerts.order(created_at: :desc)
  end
end
