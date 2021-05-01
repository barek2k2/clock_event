class Event < ApplicationRecord
  EVENT_TYPES = {
    clock_in: "clock_in",
    clock_out: "clock_out",
  }
  EVENTS_PER_PAGE = 15
  validates :user_id, presence: true
  validates :event_at, presence: true
  validates :event_type, inclusion: { in: EVENT_TYPES.keys.map(&:to_s) }

  before_validation do
    self.event_at = Time.now if self.event_at.blank?
  end

  belongs_to :user

  scope :recent, -> { order(event_at: :desc) }
  scope :sorted, -> { order(event_at: :asc) }

  def clocked_in?
    self.event_type == EVENT_TYPES[:clock_in]
  end

  def clocked_out?
    self.event_type == EVENT_TYPES[:clock_out]
  end

end
