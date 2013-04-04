class CreateMealsTable < ActiveRecord::Migration
  def up
    create_table :meals
  end

  def down
    drop_table :meals
  end
end
