class CreateGlobalFoods < ActiveRecord::Migration
  def change
    create_table :global_foods do |t|

      t.timestamps
    end
  end
end
