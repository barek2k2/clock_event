require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  before do
    @user = FactoryBot.create(:user)
    sign_in @user
  end

  describe "GET 'index'" do
    it "should be successful" do
      get :index
      expect(assigns(:events)).not_to be_nil
      expect(assigns(:event)).not_to be_nil
      expect(response).to render_template("index")
      expect(response).to be_successful
    end
  end

end
