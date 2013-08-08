class AddServingsToFoods < ActiveRecord::Migration
  def change
    add_column :foods, :serving, :integer 
  end
end
