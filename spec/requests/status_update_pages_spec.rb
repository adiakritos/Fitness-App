require 'spec_helper'

describe "StatusUpdatePages" do

  subject { page }
  
  describe "log page" do
    before { @user = User.create(email: "foobar@baz.com",
                                 password: "foobar",
                                 password_confirmation: "foobar") }
    before do 
      visit new_user_session_path
      fill_in "user_email", with: @user.email
      fill_in "user_password", with: @user.password
      click_button "Sign in"
    end
                              
    before do 
      
      @s1 = @user.status_update.build( current_bf_pct: 0.15, 
                                                      current_weight: 150,
                                                      created_at: 1.day.ago
                                                    )

      @s1.save

      @s2 = @user.status_update.build( current_bf_pct: 0.15, 
                                                       current_weight: 150,
                                                       created_at: 1.hour.ago
                                                     ) 
                             
      @s2.save

      visit status_update_path(@user.id)
    end

   
    it { should have_selector('h1', text: "Your Progress Log") } 
    it { should have_selector('title', text: "Log") }

    describe "status updates" do
      it { should have_content(@s1.current_weight) }
      it { should have_content(@s2.current_weight) }
      it { should have_content(@user.status_update.count) }
    end

    describe "creating a status_update" do
      before do 
        visit new_status_update_path 

        fill_in "status_update_current_weight", with: "150"
        fill_in "status_update_current_bf_pct", with: "20"
        click_button "Post"

        visit status_update_path(@user.id)
      end

        it { should have_selector('h3', text: "Status Updates (3)") }
    end
  end

  describe "DashboardPage" do

    before { @user = User.create(email: "foobar@baz.com",
                                 password: "foobar",
                                 password_confirmation: "foobar") }
    before do 
      visit new_user_session_path
      fill_in "user_email", with: @user.email
      fill_in "user_password", with: @user.password
      click_button "Sign in"
      
      visit new_status_update_path 

      fill_in "status_update_current_weight", with: "150"
      fill_in "status_update_current_bf_pct", with: "20"
      click_button "Post"
    end

    it { should have_selector('h3', text: "Total Overall Progress") } 
    it { should have_content(@total_weight_change)  }
    it { should have_content(@total_fat_change) }
    it { should have_content(@total_lbm_change) }
    it { should have_content(@goal) }
    it { should have_content(@time_to_goal) }
    it { should have_content(@fat_to_burn) }

    
  end
end









