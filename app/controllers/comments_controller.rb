class CommentsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  after_action :set_collaborators,    only: [:create]
  after_action :notify_collaborators, only: [:create]

  # GET /comments
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user

    session[:return_to] = request.referer

    if @comment.save
      redirect_to session.delete(:return_to)
    else
      flash[:alert] = 'Whoopsidosi!'
      redirect_to session.delete(:return_to)
    end
  end

  # PATCH/PUT /comments/1
  def update
    if @comment.update(comment_params)
      redirect_to @comment, notice: 'Comment was successfully updated.'
    else
      render 'edit'
    end
  end

  # DELETE /comments/1
  def destroy
    session[:return_to] = request.referer
    @comment.destroy
    redirect_to session.delete(:return_to), notice: 'Reactie verwijderd.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.includes(:user).find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def comment_params
      params.require(:comment).permit(:comment, :commentable_id, :commentable_type, :user_id)
    end

    def set_collaborators
      unless collaboration_exists?(current_user)
        add_user_to_collaboration(current_user)
      end
    end

    def collaboration_exists?(user)
      @comment.commentable.collaborations.exists?(user: user)
    end

    def add_user_to_collaboration(user)
      @comment.commentable.collaborations.create(user: current_user, collaborable_type: @comment.commentable_type, collaborable_id: @comment.commentable_id)
    end

    def notify_collaborators
      # Only for Alert so far.
      if @comment.commentable_type == 'Alert'
        emails = @comment.commentable.collaborations.map {|c| c.user.email} - [current_user.email]
        emails.each do |email|
          NotificationMailer.delay.comment_on_alert(@comment.commentable, @comment, email)
        end
      end
    end
end
