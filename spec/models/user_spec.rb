require 'rails_helper'

RSpec.describe User, type: :model do
  describe "User" do
    it "should belongs to user" do
      expect(User.reflect_on_association(:events).macro).to eq(:has_many)
    end
    it "Should be created with valid attributes" do
      @user = FactoryBot.build(:user)
      count = 0
      @user.save
      expect(@user.valid?).to eq(true)
      expect(count+1).to eq(User.count)
    end
    describe "#next_event_type" do
      before(:each) do
        @user = FactoryBot.create(:user)
      end
      it "should construct next event type automatically" do
        FactoryBot.create(:event, user: @user, event_at: Time.now + 10.minutes)
        expect(@user.next_event_type).to eq(Event::EVENT_TYPES[:clock_out])
        FactoryBot.create(:event, user: @user, event_at: Time.now + 10.minutes, event_type: Event::EVENT_TYPES[:clock_out])
        expect(@user.next_event_type).to eq(Event::EVENT_TYPES[:clock_in])
      end
    end
  end
end