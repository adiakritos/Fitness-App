class AddDetailsToFoods < ActiveRecord::Migration
  def change
    add_column :foods, :dynamic_fat,     :float
    add_column :foods, :dynamic_protien, :float
    add_column :foods, :dynamic_carbs,   :float
  end
end
