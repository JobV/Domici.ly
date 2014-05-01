class AlertsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_alert, only: [:show, :edit, :update, :destroy, :remove_tag]
  before_action :set_assignees, only: [:create, :edit, :new]

  # GET /alerts
  def index
    @alerts     = current_user.hoa.alerts.includes(:assignee).order('updated_at DESC')
    @new_alerts = @alerts.where(progress: 'new')
    @my_alerts  = @alerts.where(user: current_user)
    @assigned_to_me = @alerts.where(assignee: current_user)
  end

  # GET /alerts/1
  def show
    @comments = @alert.comments.includes(:user, :hoa)
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
    @alert.user = current_user if current_user
    @alert.hoa  = current_user.hoa if current_user
    if @alert.save
      notify_assignee if @alert.assignee
      redirect_to @alert, notice: I18n.t('alert.created')
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /alerts/1
  def update
    authorize @alert
    progress_before = @alert.progress
    assignee_before = @alert.assignee

    @alert.assignee_id = alert_params[:assignee_id] if alert_params[:assignee_id] && current_user.has_role?(:moderator, @alert.hoa)

    if @alert.update(alert_params)
      on_assignee_change_notify(assignee_before)
      on_progress_change_post_comment(progress_before)
      redirect_to @alert, notice: I18n.t('alert.updated')
    else
      render action: 'edit', alert: "Woops!"
    end
  end

  # DELETE /alerts/1
  def destroy
    authorize @alert
    @alert.destroy
    redirect_to dashboard_index_path, notice: I18n.t('alert.destroyed')
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

    def find_assignee(id)
      User.find(id)
    end

    # Only allow a trusted parameter "white list" through.
    def alert_params
      params.require(:alert).permit(:title, :body, :severity, :progress, :assignee_id, :tag_list, :tag)
    end

    def set_assignees
      @assignees = current_user.hoa.users
    end

    def on_assignee_change_notify(assignee_before)
      notify_assignee unless assignee_before == @alert.assignee
    end

    def notify_assignee
      AssignmentMailer.delay.assigned_to_alert(current_user, @alert.assignee, @alert)
    end

    def on_progress_change_post_comment(progress_before)
      unless progress_before == @alert.progress
        @alert.create_activity(:progress_changed, owner: current_user, hoa_id: current_user.hoa.id, parameters: {progress_before: progress_before, progress_after: @alert.progress})

        Comment.public_activity_off
        comment = @alert.comments.create
        comment.comment = "heeft de status aangepast naar #{view_context.progress_name(@alert)}"
        comment.user = current_user
        comment.save
        Comment.public_activity_on
      end
    end
end
