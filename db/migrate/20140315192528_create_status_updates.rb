class CreateStatusUpdates < ActiveRecord::Migration
  def change
    create_table :status_updates do |t|
      t.references :client
      t.string     :phase
      t.date       :entry_date
      t.float      :total_weight
      t.float      :body_fat_pct
      t.boolean    :temporary

      t.float      :weight_change
      t.float      :lbm_change
      t.float      :fat_change
      t.float      :bfp_change
      t.float      :fat_weight
      t.float      :lbm_weight
      t.float      :total_lbm_change
      t.float      :total_fat_change
      t.float      :total_weight_change
      t.float      :total_bfp_change

      t.float      :phase_change_total_weight 
      t.float      :phase_change_lbm_weight   
      t.float      :phase_change_fat_weight   
      t.float      :phase_change_body_fat_pct 

      t.float      :prev_total_weight 
      t.float      :prev_lbm_weight   
      t.float      :prev_fat_weight   
      t.float      :prev_body_fat_pct 

      t.timestamps
    end

    add_index :status_updates, :client_id

  end
end
