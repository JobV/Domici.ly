class DashboardController < ApplicationController
  def index
    @posts = Post.all
    # @posts = current_user.posts

    @alerts = Alert.all
    # @alerts = current_user.alerts
  end
end
