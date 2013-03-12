require 'spec_helper'
include Warden::Test::Helpers
Warden.test_mode!

describe "User pages" do

  subject { page }

  describe "User Settings Page" do    
    user = FactoryGirl.create(:user) 
    login_as(user, scope: :user)

    it { should have_selector('title', content:"Welcome to the Fitness App") }

  end

  Warden.test_reset! 
end
