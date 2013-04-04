class CreateMealFoodsMealsTable < ActiveRecord::Migration
  def up
    create_table :meal_foods_meals do |t|
      t.integer :meal_id, :meal_food_id
    end
  end

  def down
  end
end
