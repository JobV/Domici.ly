class ParticipationsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_participation, only: [:show, :edit, :update, :destroy]

  # GET /participations
  def index
    @participations = Participation.all
  end

  # GET /participations/1
  def show
  end

  # GET /participations/new
  def new
    @participation = Participation.new
  end

  # GET /participations/1/edit
  def edit
  end

  # POST /participations
  def create
    @participation = Participation.new(participation_params)

    if @participation.save
      redirect_to @participation, notice: 'Participation was successfully created.'
    else
      render 'new'
    end
  end

  # PATCH/PUT /participations/1
  def update
    if @participation.update(participation_params)
      redirect_to @participation.event, notice: 'Participation was successfully updated.'
    else
      render 'edit'
    end
  end

  # DELETE /participations/1
  def destroy
    @participation.destroy
    redirect_to participations_url, notice: 'Participation was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_participation
      @participation = Participation.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def participation_params
      params.require(:participation).permit(:user, :event, :presence)
    end
end
