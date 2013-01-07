class AddTargetBfPctToUsers < ActiveRecord::Migration
  def change
    add_column :users, :target_bf_pct, :float
  end
end
