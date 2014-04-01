class AlertsController < ApplicationController
  before_action :set_alert, only: [:show, :edit, :update, :destroy]

  # GET /alerts
  def index
    @alerts = current_user.hoa.alerts.order('updated_at DESC')
  end

  # GET /alerts/1
  def show
  end

  # GET /alerts/new
  def new
    @alert = Alert.new
  end

  # GET /alerts/1/edit
  def edit
  end

  # POST /alerts
  def create
    @alert = Alert.new(alert_params)
    @alert.user = current_user
    @alert.hoa  = current_user.hoa
    if @alert.save
      redirect_to(request.referrer || root_path, notice: 'Alert was successfully created.')
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /alerts/1
  def update
    authorize @alert
    if @alert.update(alert_params)
      redirect_to @alert, notice: 'Alert was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /alerts/1
  def destroy
    authorize @alert
    @alert.destroy
    redirect_to root_path, notice: 'Alert was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_alert
      @alert = Alert.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def alert_params
      params.require(:alert).permit(:title, :body, :severity, :progress)
    end
end
