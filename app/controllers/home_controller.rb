class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @event_type = current_user.next_event_type
    @event = current_user.events.new(event_type: @event_type)
  end

end
