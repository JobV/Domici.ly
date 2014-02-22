class DashboardController < ApplicationController
  def index
    @posts = Post.all
    # change to
    # @posts = current_user.posts
  end
end
