class ProfileController < ApplicationController
  before_filter :authenticate_user!

  def index
    @alerts           = current_user.alerts.includes(:assignee).order('updated_at DESC')
    @assigned_alerts  = Alert.where(assignee: current_user)
    events            = current_user.participations.includes(:event).where(presence: true)
    if events
      @events           = events.map {|p| p.event }.sort_by! { |e| e.date }
    else
      @events = []
    end
  end

  def edit
  end

  def update
    user = current_user
    if user.update(profile_params)
      redirect_to profile_path, notice: 'Profiel aangepast.'
    else
      render 'edit'
    end
  end

  private

  def profile_params
    params.require(:user).permit(:first_name, :last_name, :email, :address, :house_number, :phone_number, :postal_code, :city)
  end
end
