class CreateMeals < ActiveRecord::Migration
  def change
    create_table :meals do |t|
      t.references :client
      t.references :meal_food
      t.string :meal_name
    end
    
   add_index :meals, :client_id 
   add_index :meals, :meal_food_id
    
  end
end
