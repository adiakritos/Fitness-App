class AddStatDetailsToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      
      t.float :total_weight_change
      t.float :total_fat_change
      t.float :total_lbm_change
      t.float :fat_to_burn
      t.float :lbm
      t.float :bmr
      t.float :total_weight
      t.float :target_weight
      t.float :tdee
      t.float :deficit_pct
      t.float :daily_calorie_target
      t.float :daily_intake
      t.float :weekly_burn_rate     
      t.float :time_to_goal         
      t.float :current_weight        
      t.float :current_bf_pct        
      t.float :current_lbm           
      t.float :current_fat_weight    
      t.float :daily_caloric_deficit 
    end
  end
end
