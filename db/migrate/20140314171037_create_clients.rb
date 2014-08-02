class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string     :firstname
      t.string     :lastname
      t.string     :email
      t.float      :fat_factor
      t.float      :protein_factor
      t.float      :activity_level
      t.integer    :target_calories
      t.references :trainer
      t.boolean    :status
      t.references :status_update
      t.references :meal
      t.references :meal_food
      t.timestamps
    end

    add_index :clients, :meal_id
    add_index :clients, :meal_food_id
    add_index :clients, :status_update_id
  end
end
