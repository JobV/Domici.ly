class AlertsController < ApplicationController
  before_action :set_alert, only: [:show, :edit, :update, :destroy, :close, :reopen]

  # GET /alerts
  def index
    @alerts = current_user.hoa.alerts
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

  # POST /alerts/1/close
  def close
    authorize @alert
    @alert.state_list.add('completed')
    if @alert.save
      redirect_to @alert
    else
      redirect_to @alert, alert: 'Something went wrong.'
    end
  end

  # POST /alerts/1/reopen
  def reopen
    @alert.state_list.remove('completed')
    if @alert.save
      redirect_to @alert
    else
      redirect_to @alert, alert: 'Something went wrong.'
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
      params.require(:alert).permit(:title, :body, :severity)
    end
end
