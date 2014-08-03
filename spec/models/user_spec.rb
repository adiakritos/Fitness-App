require 'spec_helper'

describe User do
  before do 
    @user = User.new(email: "foo@bar.com", password:"foobar",
                     password_confirmation:"foobar", goal:"cut")
  end

  subject { @user }

  it { should respond_to(:email) }
  it { should respond_to(:goal) }
  it { should respond_to(:measurement) }
  it { should respond_to(:bmr_formula) }
  it { should respond_to(:fat_factor) }
  it { should respond_to(:protein_factor) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_me) } 
  it { should respond_to(:status_update) }
  it { should respond_to(:deficit_pct) }
  it { should respond_to(:activity_factor)}
  it { should respond_to(:target_bf_pct) }

  it { should be_valid }


  describe "Status Update Associations" do
    before do
      @user.save
      @older_status_update = @user.status_update.build( current_bf_pct: 0.15, 
                                                        current_weight: 150,
                                                        created_at: 1.day.ago
                                                      )

      @older_status_update.save   

      @newer_status_update = @user.status_update.build( current_bf_pct: 0.14, 
                                                        current_weight: 149,
                                                        created_at: 1.hour.ago
                                                      ) 
                              
      @newer_status_update.save

    end

    it "should have status updates in the right order" do 
      @user.status_update.should == [@newer_status_update, @older_status_update]
    end


    it "should destroy all associated status_updates" do
      status_update = @user.status_update
      @user.destroy

      status_update.each do |status_update|
        Status_update.find_by_id(status_update.id).should be_nil
      end
    end 

  end
   



end
