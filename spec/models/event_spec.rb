require 'rails_helper'

RSpec.describe Event, type: :model do
  before(:each) do
    @user = FactoryBot.create(:user)
  end
  describe "Event" do
    it "should belongs to user" do
      expect(Event.reflect_on_association(:user).macro).to eq(:belongs_to)
    end

    it "Should be created" do
      count = 0
      event = FactoryBot.create(:event, user: @user)
      expect(event.valid?).to eq(true)
      expect(count+1).to eq(Event.count)
    end
    it "should have event_at set after create" do
      expect(Event.create.event_at).not_to be_nil
    end
    describe "#ensure_valid_event" do
      it "should ensure valid update" do
        event1 = FactoryBot.create(:event, user: @user, event_at: 10.minutes.from_now)
        event2 = FactoryBot.create(:event, user: @user, event_at: 20.minutes.from_now)
        event3 = FactoryBot.create(:event, user: @user, event_at: 30.minutes.from_now)
        event4 = FactoryBot.create(:event, user: @user, event_at: 40.minutes.from_now)

        event3.update(event_at: event4.event_at+2.minutes)
        expect(event3.errors.full_messages.length > 0).to be_truthy
        expect(event3.errors.full_messages.length).to eq(1)
        expect(event3.errors.full_messages.first).to eq("Event at exceeded with next event")

        event3.update(event_at: event2.event_at-1.minutes)
        expect(event3.errors.full_messages.length > 0).to be_truthy
        expect(event3.errors.full_messages.length).to eq(1)
        expect(event3.errors.full_messages.first).to eq("Event at becomes older with the previous event")
      end
    end
    describe "scope" do
      before(:each) do
        @event1 = FactoryBot.create(:event, user: @user, event_at: 10.minutes.from_now)
        @event2 = FactoryBot.create(:event, user: @user, event_at: 20.minutes.from_now)
        @event3 = FactoryBot.create(:event, user: @user, event_at: 30.minutes.from_now)
        @event4 = FactoryBot.create(:event, user: @user, event_at: 40.minutes.from_now)
      end
      describe "#recent" do
        it "should return recent event first" do
          expect(@user.events.recent.pluck(:id)).to eq([@event4.id,@event3.id,@event2.id,@event1.id])
        end
      end
      describe "#sorted" do
        it "should return recent event first" do
          expect(@user.events.sorted.pluck(:id)).to eq([@event1.id,@event2.id,@event3.id,@event4.id])
        end
      end
    end
  end
end