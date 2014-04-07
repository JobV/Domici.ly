class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /events
  def index
    @events = Event.all
  end

  # GET /events/1
  def show
    @comments = @event.comments
    @participation = @event.participations.find_or_create_by(user: current_user)
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
    @hour = @event.date.hour.to_s
    @min  = @event.date.min.to_s
    @date = @event.date.strftime("%Y-%m-%d")
  end

  # POST /events
  def create
    @event = Event.new(event_params)
    @event.user = current_user
    @event.date = @event.date.change({hour: params[:event][:hour], min: params[:event][:min]})

    if @event.save
      redirect_to @event, notice: 'Event was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /events/1
  def update
    original_date = @event.date
    @event.assign_attributes(event_params)
    @event.date = original_date.change({hour: params[:event][:hour], min: params[:event][:min]})
    if @event.save
      redirect_to @event, notice: 'Event was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /events/1
  def destroy
    @event.destroy
    redirect_to events_url, notice: 'Event was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def event_params
      params.require(:event).permit(:date, :name, :location, :hour, :min, :description)
    end

    def update_date_with_time(date, time)
      date.change({hour: time.hour, min: time.min})
    end
end
