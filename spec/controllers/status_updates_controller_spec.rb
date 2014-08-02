require 'spec_helper'

describe StatusUpdatesController do

  before :each do
    @trainer = create(:trainer)
    @client  = create(:client, trainer: @trainer)
    @status_updates = create(:status_update, client: @client)
    sign_in(@trainer)
  end

  describe "GET #show" do

    it "sets current_client session with params" do
      get :show, id: @client.id 
      current_session = session[:current_client]
      expect(current_session).to_not be_empty
    end
    
    it "finds all the status_updates for that client" do 
      status_updates = @status_updates
      get :show, id: @client.id 
      expect(assigns(:status_updates)).to match_array [status_updates]
    end
    it "sets those status updates to the global @status_update variable"
  end
end    
