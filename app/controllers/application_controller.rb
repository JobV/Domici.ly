class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:error] = "Helaas pindakaas. Die actie mag je niet doen."
    redirect_to(request.referrer || root_path)
  end
end
