class ApplicationController < ActionController::Base
  before_filter :authenticate_user!
  include PublicActivity::StoreController
  include Pundit
  protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    # Only add some parameters
    devise_parameter_sanitizer.for(:accept_invitation).concat [:first_name, :last_name, :hoa, :role]

    devise_parameter_sanitizer.for(:invite).concat [:first_name, :last_name, :hoa, :role]
  end

  private

  def user_not_authorized
    flash[:error] = "Helaas pindakaas. Die actie mag je niet doen."
    redirect_to(request.referrer || root_path)
  end
end

## Include if necessary
# http://railscasts.com/episodes/406-public-activity?view=asciicast
# def current_user
#   @current_user ||= User.find(session[:user_id]) if session[:user_id]
# end
# helper_method :current_user
# hide_action :current_user
