class ProfileController < ApplicationController
  def index
    @alerts = current_user.alerts.order('updated_at DESC')
  end

  def edit
  end

  def update
    user = current_user
    if user.update(profile_params)
      redirect_to profile_path, notice: 'Profiel aangepast.'
    else
      render action: 'edit'
    end
  end

  private

  def profile_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end
end
