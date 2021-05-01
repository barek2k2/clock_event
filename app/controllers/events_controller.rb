class EventsController < ApplicationController
  EVENTS_PER_PAGE = 15
  before_action :authenticate_user!
  before_action :load_events

  def index
    @events = @events.asc.paginate page: params[:page], per_page: EVENTS_PER_PAGE
  end

  def create
    event = build_new_event
    if event.save
      redirect_to root_path, notice: "#{format_event_type(event_params[:event_type])} traced successfully!"
    else
      redirect_to root_path, alert: event.errors.full_messages.join(", ")
    end
  end
  
  def edit
    @event = @events.find(params[:id])
  end

  def update
    @event = @events.find(params[:id])
    if @event.update(event_params)
      redirect_to events_path, notice: "Event was updated successfully!"
    else
      render "edit"
    end
  end

  private
  def build_new_event
    event = @events.new(event_params)
    event.event_at = Time.now
    event.location_ip = request.remote_ip
    event.user_agent = request.user_agent
    event
  end
  
  def load_events
    @events = current_user.events
  end
  
  def event_params
    params.require(:event).permit(:event_type, :event_at)
  end

end
