class AlertsController < ApplicationController
  respond_to :html, :json

  before_filter :authenticate_user!

  before_action :set_alert,
    only: [:show, :edit, :update, :destroy, :remove_tag]
  before_action :set_assignees, only: [:create, :edit, :new]

  after_action :set_collaborators,  only: [:create, :update]

  after_action only: [:show] do
    @alert.mark_as_read!(current_user) unless @alert.read?(current_user)
  end

  # after_action :verify_authorized, except: [:index]

  # GET /alerts
  def index
    if current_user.has_role?(:moderator, current_user.hoa)
      @alerts = current_user.hoa.alerts \
      .includes(:assignee, :user, :readings, taggings: [:tag]) \
      .order('alerts.updated_at DESC')
    else
      @alerts = current_user.hoa.alerts \
      .includes(:assignee, :user, :readings, taggings: [:tag]) \
      .joins("INNER JOIN collaborations").where(user_id: current_user.id).uniq \
      .order('alerts.updated_at DESC')
    end
  end

  # GET /alerts/1
  def show
    authorize @alert
    @comments = @alert.comments.includes(:user)
    @comment = Comment.new(user: current_user)

    @collaboration      = @alert.collaborations.find_by(user: current_user)
    @new_collaboration  = @alert.collaborations.new(user: current_user)
    @collaborations     = @alert.collaborations.includes(:user)

    @users = current_user.hoa.users
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
      set_collaborators
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

      # If inline editing
      if request.xhr?
        respond_with @alert
      else
        redirect_to @alert, notice: I18n.t('alert.updated')
      end
    else
      render action: 'edit', alert: "Woops!"
    end
  end

  # DELETE /alerts/1
  def destroy
    authorize @alert
    @alert.destroy
    redirect_to alerts_path, notice: I18n.t('alert.destroyed')
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
      params.require(:alert).permit(:title, :body, :severity, :progress, :assignee_id, :tag_list, :tag, :user_id)
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

    def set_collaborators
      add_user_as_collaborator(current_user)
      add_user_as_collaborator(@alert.assignee) if @alert.assignee
    end

    def add_user_as_collaborator(user)
      @alert.collaborations.create(user: user) unless collaboration_exists?(user)
    end

    def collaboration_exists?(user)
      @alert.collaborations.exists?(user_id: user.id)
    end
end
