class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @event = current_user.events.new(event_type: current_user.next_event_type)
    @events = current_user.events.sorted.paginate page: params[:page], per_page: Event::EVENTS_PER_PAGE
  end

end
