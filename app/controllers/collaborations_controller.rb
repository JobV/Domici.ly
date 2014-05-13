class CollaborationsController < ApplicationController
  def create
    @collaboration = Collaboration.new(collaboration_params)
    if @collaboration.save
      redirect_to @collaboration.collaborable
    else
      redirect_to alerts_path
    end
  end

  def destroy
    @collaboration = Collaboration.find(params[:id])
    authorize @collaboration
    @collaboration.destroy
    redirect_to @collaboration.collaborable
  end

  private

  def collaboration_params
    params.require(:collaboration).permit(:collaborable_type, :collaborable_id, :user_id)
  end
end
