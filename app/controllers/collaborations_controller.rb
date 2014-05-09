class CollaborationsController < ApplicationController
  def create
    @collaboration = Collaboration.new(collaboration_params)
    @collaboration.user = current_user
    @collaboration.save
    redirect_to @collaboration.collaborable
  end

  def destroy
    @collaboration = Collaboration.find(params[:id])
    authorize @collaboration
    @collaboration.destroy
    redirect_to @collaboration.collaborable
  end

  private

  def collaboration_params
    params.permit(:collaborable_type, :collaborable_id)
  end
end
