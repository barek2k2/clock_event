class EventsController < ApplicationController
  include EventsHelper
  EVENTS_PER_PAGE = 15
  
  before_action :authenticate_user!
  before_action :load_events

  def create
    event = construct_new_event
    if event.save
      redirect_to root_path, notice: "#{format_event_type(event.event_type)} traced successfully!"
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
      redirect_to root_path, notice: "Event was updated successfully!"
    else
      render "edit"
    end
  end

  private
  def construct_new_event
    event = @events.new
    event.event_at = Time.now
    event.event_type = current_user.next_event_type
    event.location_ip = request.remote_ip
    event.user_agent = request.user_agent
    event
  end
  
  def load_events
    @events = current_user.events
  end
  
  def event_params
    params.require(:event).permit(:event_at)
  end

end
