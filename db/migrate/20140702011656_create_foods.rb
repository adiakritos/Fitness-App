class CreateFoods < ActiveRecord::Migration
  def change
    create_table :foods do |t|
      t.references :meal
      t.references :client

      t.string     :type
      t.string     :name
      t.string     :brand
      t.float      :servings
      t.float      :serving_size
      t.string     :units
      t.float      :glycemic_index

      t.float      :carbs
      t.float      :protein
      t.float      :fat

      t.float      :saturated_fat
      t.float      :polyunsaturated_fat
      t.float      :monosaturated_fat
      t.float      :trans_fat
      t.float      :cholesterol
      t.float      :vitamin_a
      t.float      :vitamin_c
      t.float      :sodium
      t.float      :potassium
      t.float      :dietary_fiber
      t.float      :sugar
      t.float      :protein
      t.float      :calcium
      t.float      :iron
      
      t.float      :dynamic_carbs
      t.float      :dynamic_protein
      t.float      :dynamic_fat
      t.float      :dynamic_sodium

      t.timestamps
    end

    add_index :foods, :meal_id
    add_index :foods, :client_id
  end
end
