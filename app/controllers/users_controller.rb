class UsersController < ApplicationController
  respond_to :html, :json

  before_filter :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  def index
    @users = User.all
  end

  # GET /users/1
  def show
    authorize @user
    redirect_to root_path unless current_user.hoa == @user.hoa
    @alerts = @user.alerts.includes(:assignee)
    @assigned_alerts = Alert.where(assignee: @user)
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    authorize @user
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to @user, notice: 'User was successfully created.'
    else
      render 'new'
    end
  end

  # PATCH/PUT /users/1
  def update
    authorize @user
    if @user.update(user_params)
      if request.xhr?
        respond_with @user
      else
        redirect_to @user, notice: 'Gebruiker is aangepast.'
      end
    else
      render 'edit'
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  # POST /users/1/remove
  def remove_from_hoa
    user =  User.find(params[:id])
    authorize current_user
    user.hoa = nil
    if user.save
      redirect_to organisation_path, notice: "#{user.full_name} is verwijderd uit #{current_user.hoa_name}"
    else
      redirect_to organisation_path, alert: "Whoopsie! Something went wrong!"
    end
  end

  # POST /users/:id/change_role
  def change_role
    user = User.find(params[:id])
    role = params[:user][:role]
    authorize current_user
    if user == current_user
      notice = 'Je kan deze actie niet op jezelf doen.'
    elsif role
      remove_roles(user)
      user.add_role to_safe_sym(role, ['moderator', 'maintenance']), user.hoa
      notice = "#{user.full_name} heeft nu een nieuwe rol."
    else
      remove_roles(user)
      notice = "#{user.full_name} is nu eigenaar."
    end
    redirect_to members_path, notice: notice
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def user_params
    params.require(:user).permit(:hoa_id, :role, :first_name, :last_name, :email, :address, :house_number, :phone_number, :postal_code, :city)
  end

  def remove_roles(user)
    user.remove_role :moderator
    user.remove_role :maintenance
  end

  def to_safe_sym(value, valid_values)
    symbolized = nil
    valid_values.each do |v|
      if v == value
         symbolized = v.to_sym
        break
      end
    end
    symbolized
  end
end
