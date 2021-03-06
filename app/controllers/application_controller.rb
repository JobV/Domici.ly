class ApplicationController < ActionController::Base
  # before_filter :authenticate_user!

  include UrlHelper

  include PublicActivity::StoreController
  include Pundit
  protect_from_forgery with: :null_session

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_filter :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    redirect_to_correct_subdomain(resource)
  end

  def redirect_to_correct_subdomain(user)
    if user.hoa && user.hoa.subdomain_name
      if request.subdomain == user.hoa.subdomain_name
        return organisation_path
      else
        return organisation_url(subdomain: user.hoa.subdomain_name)
      end
    else
      user.hoa ? organisation_url(subdomain: 'app') : new_hoa_url(subdomain: 'app')
    end
  end

protected

  def configure_permitted_parameters
    # Only add some parameters
    devise_parameter_sanitizer.for(:accept_invitation).concat [:first_name, :last_name, :hoa, :role]

    devise_parameter_sanitizer.for(:sign_up).concat [:first_name, :last_name]

    devise_parameter_sanitizer.for(:invite).concat [:first_name, :last_name, :hoa, :role, :emails]

    devise_parameter_sanitizer.for(:account_update) { |u|
          u.permit(:password, :password_confirmation, :current_password)
        }
  end

private

  def user_not_authorized
    flash[:error] = "Die actie mag je niet doen."
    redirect_to(request.referrer || root_path)
  end
end
