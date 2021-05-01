FactoryBot.define do
  factory :event do
    event_type { Event::EVENT_TYPES[:clock_in] }
  end
end
