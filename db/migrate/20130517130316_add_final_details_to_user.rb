class AddFinalDetailsToUser < ActiveRecord::Migration
  def change
    change_table :users do |t|

      t.remove :total_weight_change
      t.remove :total_fat_change
      t.remove :total_lbm_change
      t.remove :fat_to_burn
      t.remove :lbm
      t.remove :bmr
      t.remove :total_weight
      t.remove :target_weight
      t.remove :tdee
      t.remove :deficit_pct
      t.remove :daily_calorie_target
      t.remove :daily_intake
      t.remove :weekly_burn_rate
      t.remove :time_to_goal
      t.remove :current_weight
      t.remove :current_bf_pct
      t.remove :current_lbm
      t.remove :current_fat_weight
      t.remove :daily_caloric_deficit

    end
  end
end
