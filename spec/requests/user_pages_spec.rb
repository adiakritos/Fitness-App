require 'spec_helper'
include Warden::Test::Helpers
Warden.test_mode!

describe "User pages" do

  subject { page }

  describe "User Settings Page" do    
    let(:user) { FactoryGirl.create(:user) }
    login_as(:user, scope: :user)

    before { visit edit_user_registration_path }

    it { should have_selector('h1',    text: "User Settings") }
    it { should have_selector('title', text: "User Settings") }


   
  end
   Warden.test_reset!
end
