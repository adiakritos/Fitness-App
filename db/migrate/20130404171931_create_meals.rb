class CreateMeals < ActiveRecord::Migration
  def change
    create_table :meals do |t|
      t.references :user
      t.string  :meal_name
    end
  end
end
