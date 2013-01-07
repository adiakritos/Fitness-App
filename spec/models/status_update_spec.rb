require 'spec_helper'

describe StatusUpdate do
   let(:user) { FactoryGirl.create(:user) } 
   
   before { @status_update = user.status_update.build(current_weight: "149", 
                                                      current_bf_pct:"15", 
                                                     )}
  

   subject { @status_update }
   
   it { should respond_to(:user_id) }
   it { should respond_to(:current_weight) }
   it { should respond_to(:current_bf_pct) }
   it { should respond_to(:current_lbm) }
   it { should respond_to(:current_fat_weight) }
   it { should respond_to(:change_in_weight) }
   it { should respond_to(:change_in_bf_pct) }
   it { should respond_to(:change_in_lbm) }
   it { should respond_to(:change_in_fat_weight) }
   it { should respond_to(:total_weight_change) }
   it { should respond_to(:total_bf_pct_change) }
   it { should respond_to(:total_lbm_change) }
   it { should respond_to(:total_fat_change) }
   
   its(:user) { should == user }
   

   it { should be_valid } 

   describe "when user_id is not present" do
     before { @status_update.user_id = nil }
     it { should_not be_valid }
   end                                       
   
   describe "accessible attributes" do
     it "should not allow access to user_id" do
        expect do
          StatusUpdate.new(user_id: user.id)
        end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
     end
   end

   describe "when weight is not present" do
     before { @status_update.current_weight = nil }
     it { should_not be_valid }
   end

   describe "when weight is blank" do
     before { @status_update.current_weight = "  " }
     it { should_not be_valid }
   end

   describe "when weight is too long" do
     before { @status_update.current_weight = '11111' }
     it { should_not be_valid }
   end

   describe "when weight is not a number" do
     before { @status_update.current_weight = 'let' }
   end

   describe "when bodyfat percet is not present" do
     before { @status_update.current_bf_pct = nil }
     it { should_not be_valid }
   end

   describe "when bodyfat percent is blank" do
     before { @status_update.current_bf_pct = "  " }
     it { should_not be_valid }
   end

   describe "when bodyfat percent is too long" do
     before { @status_update.current_bf_pct = '15909' }
     it { should_not be_valid } 
   end                   

   describe "when bodyfat percent is not a number" do
     before { @status_update.current_bf_pct = "a number" }
     it { should_not be_valid }
   end


   describe "after saving the user" do
      before { user.save }    

      describe "when lean body mass isn't present" do
        before { @status_update.current_lbm = nil }
        it { should_not be_valid }
      end

      describe "when current fat weight isn't present" do
        before { @status_update.current_fat_weight = nil }
        it { should_not be_valid }
      end
   end

end

