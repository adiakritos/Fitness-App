class AddTempToStatusUpdate < ActiveRecord::Migration
  def change
    add_column :status_updates, :temporary, :string
  end
end
