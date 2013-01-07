class CreateStatusUpdates < ActiveRecord::Migration
  def change
    create_table :status_updates do |t|

      t.timestamps
    end
  end
end
