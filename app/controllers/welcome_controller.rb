class WelcomeController < ApplicationController
  before_filter :authenticate_user!

  def welcome
    redirect_to dashboard_index_path if current_user.hoa
  end
end
