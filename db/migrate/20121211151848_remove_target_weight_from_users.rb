class RemoveTargetWeightFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :target_weight
  end

  def down
    add_column :users, :target_weight, :string
  end
end
