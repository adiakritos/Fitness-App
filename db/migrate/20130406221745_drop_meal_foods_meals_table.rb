class DropMealFoodsMealsTable < ActiveRecord::Migration
  def up
    drop_table :meal_foods_meals
  end

  def down
  end
end
