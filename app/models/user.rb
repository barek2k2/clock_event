class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :events

  def next_event_type
    latest_event = self.events.recent.first
    return Event::EVENT_TYPES[:clock_in] unless latest_event

    if latest_event.clocked_in?
      Event::EVENT_TYPES[:clock_out]
    else
      Event::EVENT_TYPES[:clock_in]
    end
  end

end
