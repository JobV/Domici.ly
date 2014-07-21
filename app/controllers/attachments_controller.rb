class AttachmentsController < ApplicationController
  before_action :set_attachment, only: [:show, :edit, :update, :destroy]

  # GET /attachments
  def index
    @attachments = Attachment.all
  end

  # GET /attachments/1
  def show
  end

  # GET /attachments/new
  def new
    @attachment = Attachment.new
  end

  # GET /attachments/1/edit
  def edit
  end

  # POST /attachments
  def create
    @attachment = Attachment.new(attachment_params)

    if @attachment.save
      redirect_to @attachment, notice: 'Attachment toegevoegd.'
    else
      render :new
    end
  end

  # PATCH/PUT /attachments/1
  def update
    if @attachment.update(attachment_params)
      redirect_to @attachment, notice: 'Attachment was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /attachments/1
  def destroy
    alert = @attachment.alert
    @attachment.destroy
    redirect_to alert_path(alert), notice: 'Attachment is verwijderd.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_attachment
      @attachment = Attachment.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def attachment_params
      params.require(:attachment).permit(:alert_id, :attachment)
    end
end
