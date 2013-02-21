require 'spec_helper'

describe "User pages" do

  describe "User Settings Page" do    
    let(:user) { FactoryGirl.create(:user) }
    before { visit edit_user_path(user) }

    describe 'page' do
      it { should have_selector('h1',    text: "Update your settings!") }
      it { should have_selector('title', text: "Edit User Settings") }
    end

    describe "with valid information" do
      before {click_button "Save Changes"}
      it { should have_content('error') }
    end

    describe "with valid information" do
      after {click_button "Save Changes"}          
      it { should have_content('success') }
    end
  end
end
