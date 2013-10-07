class CreateFoods < ActiveRecord::Migration
  def change
    create_table :foods do |t|
      t.references :user
      t.references :meal
      t.string     :name
      t.string     :brand
      t.float      :fat
      t.float      :carbs
      t.float      :protien
      t.string     :type
      t.string     :measure_type
      t.float      :serving_size
      t.float      :servings
      t.float      :dynamic_fat
      t.float      :dynamic_protien
      t.float      :dynamic_carbs
      t.float      :dynamic_serving_size
      t.timestamps
    end

    add_index :foods, :user_id
    add_index :foods, :meal_id
  end
end
