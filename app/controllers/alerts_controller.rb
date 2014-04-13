class AlertsController < ApplicationController
  before_action :set_alert, only: [:show, :edit, :update, :destroy, :remove_tag]
  before_action :set_assignees, only: [:edit, :new]

  # GET /alerts
  def index
    @alerts     = current_user.hoa.alerts.order('updated_at DESC')
    @new_alerts = @alerts.where(progress: 'new')
    @my_alerts  = @alerts.where(user: current_user)
    @assigned_to_me = @alerts.where(assignee: current_user)
  end

  # GET /alerts/1
  def show
    @comments = @alert.comments
    @comment = Comment.new(user: current_user)
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
      redirect_to @alert, notice: 'Alert was successfully created.'
    else
      render action: 'new'
    end
  end


  # PATCH/PUT /alerts/1
  def update
    authorize @alert
    progress_before = @alert.progress

    if @alert.update(alert_params)

      # REFACTOR
      # on progress update, perfom shit
      unless progress_before == @alert.progress
        @alert.create_activity(:progress_changed, owner: current_user, hoa_id: current_user.hoa.id, parameters: {progress_before: progress_before, progress_after: @alert.progress})

        Comment.public_activity_off
        comment = @alert.comments.create
        comment.comment = "heeft de status aangepast naar #{view_context.progress_name(@alert)}"
        comment.user = current_user
        comment.save
        Comment.public_activity_on
      end

      redirect_to @alert, notice: "Melding aangepast!"
    else
      render action: 'edit', alert: "Woops!"
    end
  end

  # DELETE /alerts/1
  def destroy
    authorize @alert
    @alert.destroy
    redirect_to root_path, notice: 'Alert was successfully destroyed.'
  end

  # POST /alert/1/remove_tag
  def remove_tag
    session[:return_to] = request.referer
    @alert.tag_list.remove(params[:tag])
    @alert.save
    redirect_to session.delete(:return_to)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_alert
      @alert = Alert.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def alert_params
      params.require(:alert).permit(:title, :body, :severity, :progress, :assignee_id, :tag_list, :tag)
    end

    def set_assignees
      @assignees = current_user.hoa.users
    end
end
