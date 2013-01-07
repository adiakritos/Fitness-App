class AddTargetWeightToUsers < ActiveRecord::Migration
  def change
    add_column :users, :target_weight, :integer
  end
end
