class AddDetailsToStatusUpdate < ActiveRecord::Migration
  def change
    add_column :status_updates, :user_id, :integer
    add_column :status_updates, :current_weight, :float
    add_column :status_updates, :current_bf_pct, :float
    add_column :status_updates, :current_lbm, :float
    add_column :status_updates, :current_fat_weight, :float
    add_column :status_updates, :change_in_weight, :float
    add_column :status_updates, :change_in_bf_pct, :float
    add_column :status_updates, :change_in_lbm, :float
    add_column :status_updates, :change_in_fat_weight, :float
    add_column :status_updates, :total_weight_change, :float
    add_column :status_updates, :total_bf_pct_change, :float
    add_column :status_updates, :total_lbm_change, :float
    add_column :status_updates, :total_fat_change, :float

  end
end
