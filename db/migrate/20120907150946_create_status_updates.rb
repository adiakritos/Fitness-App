class CreateStatusUpdates < ActiveRecord::Migration
  def change
    create_table :status_updates do |t|
      t.references :user
      t.float :current_weight
      t.float :current_bf_pct
      t.float :current_lbm
      t.float :current_fat_weight
      t.float :change_in_weight
      t.float :change_in_bf_pct
      t.float :change_in_lbm
      t.float :change_in_fat_weight
      t.float :total_weight_change
      t.float :total_bf_pct_change
      t.float :total_lbm_change
      t.float :total_fat_change
      t.string :temporary
      t.timestamps
    end

    add_index :status_updates, :user_id
  end
end
