class Event < ApplicationRecord
  EVENT_TYPES = {
    clock_in: "clock_in",
    clock_out: "clock_out",
  }
  EVENTS_PER_PAGE = 15
  validates :user_id, presence: true
  validates :event_at, presence: true
  validates :event_type, presence: true, inclusion: { in: EVENT_TYPES.keys.map(&:to_s) }
  validate :ensure_valid_event, on: :update

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

  private
  def ensure_valid_event
    latest_next_event = Event.sorted.where("event_at > ? ", self.event_at_was).first
    if latest_next_event&.event_at < self.event_at
      self.errors.add(:event_at, "Invalid time")
    end
  end

end
