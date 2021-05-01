class EventsController < ApplicationController
  EVENTS_PER_PAGE = 15
  before_action :authenticate_user!

  def index
    @events = current_user.events.asc.paginate page: params[:page], per_page: EVENTS_PER_PAGE
  end

  def create
    event = build_event
    if event.save
      redirect_to root_path, notice: "#{event_params[:event_type].to_s.humanize} traced successfully!"
    else
      redirect_to root_path, alert: event.errors.full_messages.join(", ")
    end
  end

  private
  def build_event
    event = current_user.events.new(event_params)
    event.event_at = Time.now
    event.location_ip = request.remote_ip
    event.user_agent = request.user_agent
    event
  end
  def event_params
    params.require(:event).permit(:event_type)
  end

end
