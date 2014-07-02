class EventsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  after_action only: [:show] do
    @event.mark_as_read!(current_user) unless @event.read?(current_user)
  end

  # GET /events
  def index
    @events     = current_user.hoa.events.order('date ASC')
    @coming     = events_with_presence(true)
    @not_coming = events_with_presence(false)
  end

  # GET /events/1
  def show
    authorize @event
    @comments = @event.comments
    @participation = @event.participations.find_or_create_by(user: current_user)

    participations  = @event.participations.where(event: @event)
    @people_present = participations.where(presence: true)
    @people_absent  = participations.where(presence: false)
    @no_status      = (current_user.hoa.users - @people_absent - @people_present).count
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
    @event.hoa = current_user.hoa
    @event.date = format_event_date(@event)
    if @event.save
      redirect_to @event, notice: I18n.t('event.created')
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /events/1
  def update
    original_date = @event.date
    @event.assign_attributes(event_params)
    @event.date = format_event_date(@event)
    if @event.save
      redirect_to @event, notice: I18n.t('event.updated')
    else
      render action: 'edit'
    end
  end

  # DELETE /events/1
  def destroy
    @event.destroy
    redirect_to events_url, notice: I18n.t('event.destroyed')
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def event_params
    params.require(:event).permit(:date, :title, :location, :hour, :min, :description)
  end

  def update_date_with_time(date, time)
    date.change({hour: time.hour, min: time.min})
  end

  # REFACTOR: make full SQL query
  def events_with_presence(bool)
    current_user.participations.includes(:event).where(presence: bool).map { |p| p.event }
  end

  def format_event_date(event)
    event.date.change({hour: params[:event][:hour], min: params[:event][:min]}) if event.date
  end
end
