class SupportMessagesController < ApplicationController
  before_action :set_support_message, only: [:show, :edit, :update, :destroy]

  # GET /support_messages
  def index
    @support_messages = SupportMessage.all
  end

  # GET /support_messages/1
  def show
  end

  # GET /support_messages/new
  def new
    @support_message = SupportMessage.new
  end

  # GET /support_messages/1/edit
  def edit
  end

  # POST /support_messages
  def create
    @support_message = SupportMessage.new(support_message_params)
    @support_message.user = current_user
    @support_message.hoa  = current_user.hoa
    if @support_message.save
      send_message_to_support(current_user,@support_message.body)
      redirect_to root_path, notice: 'We emailen je zo snel mogelijk terug!'
    else
      render :new
    end
  end

  # PATCH/PUT /support_messages/1
  def update
    if @support_message.update(support_message_params)
      redirect_to @support_message, notice: 'Support message was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /support_messages/1
  def destroy
    @support_message.destroy
    redirect_to support_messages_url, notice: 'Support message was successfully destroyed.'
  end

  private
    def send_message_to_support(sender, message)
      SupportMailer.delay.support_ticket(current_user, message)
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_support_message
      @support_message = SupportMessage.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def support_message_params
      params.require(:support_message).permit(:body, :user_id, :hoa_id)
    end
end
