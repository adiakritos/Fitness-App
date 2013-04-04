class AddMealNameToMeals < ActiveRecord::Migration
  def change
    add_column :meals, :meal_name, :string
  end
end
