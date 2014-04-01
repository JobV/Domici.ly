class HoasController < ApplicationController
  before_action :set_hoa, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized, :except => [:index, :create]

  # GET /hoas
  def index
    @hoas = Hoa.all
  end

  # GET /hoas/1
  def show
    authorize @hoa
    @alerts = current_user.hoa ? current_user.hoa.alerts.order(created_at: :desc) : current_user.alerts.order(created_at: :desc)
    @moderators = User.with_role(:moderator, current_user.hoa)
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
      redirect_to @hoa, notice: 'Hoa was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /hoas/1
  def update
    authorize @hoa
    if @hoa.update(hoa_params)
      redirect_to @hoa, notice: 'Hoa was successfully updated.'
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hoa
      @hoa = Hoa.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def hoa_params
      params.require(:hoa).permit(:name)
    end
end
