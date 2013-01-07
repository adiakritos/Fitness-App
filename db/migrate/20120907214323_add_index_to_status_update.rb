class AddIndexToStatusUpdate < ActiveRecord::Migration
  def change
    add_index :status_updates, [:user_id, :created_at] 
  end
end
