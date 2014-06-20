class WelcomeController < ApplicationController
  before_filter :authenticate_user!

  def welcome
    redirect_to organisation_path if current_user.hoa
    redirect_to new_hoa_path
  end
end
