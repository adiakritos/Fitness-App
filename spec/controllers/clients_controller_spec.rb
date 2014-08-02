require 'spec_helper'

describe ClientsController do

  before :each do
    @trainer = create(:trainer)
    sign_in(@trainer)
  end

  describe "GET #index" do

    context "with current_client session" do
      it "clears the current_clients session" do
        get :index
        current_session = session[:current_client]
        expect(current_session).to eq nil
      end
    end

    it "renders the :index view" do
      get :index
      expect(response).to render_template :index 
    end
  end
end    
