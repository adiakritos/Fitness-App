class AddTargetCalorieIntakeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :target_caloric_intake, :integer
  end
end
