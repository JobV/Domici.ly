class HoasController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_hoa, only: [:billing, :members, :edit, :update, :destroy]
  after_action :verify_authorized, :except => [:show, :index, :create]

  # GET /hoas
  def index
    @hoas = Hoa.all
  end

  # GET /hoas/1
  def show
    current_user.hoa ? set_activities : @activities = []
    @post = Post.new user: current_user

    @unread_alerts = current_user.hoa.alerts.unread_by(current_user)
  end

  # GET /hoas/new
  def new
    @hoa = Hoa.new
    authorize @hoa
  end

  # GET /hoas/1/edit
  def edit
    authorize @hoa
  end

  # POST /hoas
  def create
    @hoa = Hoa.new(hoa_params)
    if @hoa.save
      redirect_to organisation_path, notice: 'Hoa was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /hoas/1
  def update
    authorize @hoa
    if @hoa.update(hoa_params)
      redirect_to organisation_path, notice: 'Hoa was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /hoas/1
  def destroy
    authorize @hoa
    @hoa.destroy
    redirect_to hoas_url, notice: 'Hoa was successfully destroyed.'
  end

  def members
    authorize @hoa
    @moderators        = @hoa.users.with_role(:moderator, current_user.hoa)
    @maintenance_staff = @hoa.users.with_role(:maintenance, current_user.hoa)
    @owners            = @hoa.users - @moderators - @maintenance_staff
  end

  def billing
    authorize @hoa
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hoa
      @hoa = current_user.hoa
    end

    # Only allow a trusted parameter "white list" through.
    def hoa_params
      params.require(:hoa).permit(:name)
    end

    def set_activities
      @activities = PublicActivity::Activity
        .where(hoa_id: current_user.hoa.id)
        .includes(:owner, :trackable)
        .order('created_at desc')
        .limit(20)
    end
end
