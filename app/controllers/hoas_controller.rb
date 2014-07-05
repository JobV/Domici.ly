class HoasController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_hoa, only: [:billing, :members, :edit, :update, :destroy]
  after_action :verify_authorized, :except => [:show, :index, :create, :check_subdomain_name]

  # GET /hoas
  def index
    @hoas = Hoa.all
    authorize @hoas
  end

  # GET /hoas/1
  def show
    redirect_to welcome_path unless current_user.hoa
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
      @hoa.users << current_user
      current_user.add_role :moderator, @hoa
      redirect_to organisation_url(subdomain: current_user.hoa.subdomain_name), notice: 'Jouw vereniging is aangemaakt, gefeliciteerd!'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /hoas/1
  def update
    authorize @hoa
    if @hoa.update(hoa_params)
      redirect_to organisation_path, notice: 'Vereniging aangepast.'
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

  def check_subdomain_name
    if valid_subdomain_name?(params[:name])
      render nothing: true, status: 200
    else
      render nothing: true, status: 409
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hoa
      @hoa = current_user.hoa
    end

    # Only allow a trusted parameter "white list" through.
    def hoa_params
      params.require(:hoa).permit(:name, :subdomain_name, :address, :postal_code, :city, :allow_posts)
    end

    def set_activities
      @activities = PublicActivity::Activity
        .where(hoa_id: current_user.hoa.id)
        .includes(:owner, trackable: [:hoa])
        .order('created_at desc')
        .limit(20)
    end

    def valid_subdomain_name?(name)
      Hoa.where(subdomain_name: name).count == 0 &&
      name.length < 21
    end
end
