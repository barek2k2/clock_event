require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  before do
    @user = FactoryBot.create(:user)
    sign_in @user
  end

  describe "POST 'create'" do
    it "should be successful" do
      post :create, params: {}
      expect(response).to redirect_to(root_url)
      expect(flash[:notice]).not_to be_nil
    end
  end

  describe "GET 'edit'" do
    before do
      @event = FactoryBot.create(:event, user: @user)
    end
    it "should be successful" do
      get :edit, params: {id: @event.id}
      expect(assigns(:event)).not_to be_nil
      expect(response).to render_template("edit")
      expect(response).to be_successful
    end
  end

  describe "PUT 'update'" do
    before do
      @event1 = FactoryBot.create(:event, user: @user, event_at: 10.minutes.from_now)
      @event2 = FactoryBot.create(:event, user: @user, event_at: 20.minutes.from_now)
      @event3 = FactoryBot.create(:event, user: @user, event_at: 30.minutes.from_now)
    end
    context "when event_at is less than next event's event_at" do
      it "should be successful" do
        put :update, params: {id: @event2.id, event: {event_at: @event3.event_at - 2.minutes}}
        expect(assigns(:event)).not_to be_nil
        expect(response).to redirect_to(root_url)
        expect(flash[:notice]).to eq("Event was updated successfully!")
      end
    end

    context "when event_at is greater than next event's event_at" do
      it "should not be successful" do
        put :update, params: {id: @event2.id, event: {event_at: @event3.event_at + 2.minutes}}
        expect(assigns(:event)).not_to be_nil
        expect(response).to render_template("edit")
      end
    end

  end

end
