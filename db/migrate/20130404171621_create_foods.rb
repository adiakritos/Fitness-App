class CreateFoods < ActiveRecord::Migration
  def change
    create_table :foods do |t|
      t.string :name
      t.string :brand
      t.float :fat
      t.float :carbs
      t.float :protien
      t.string :type

      t.timestamps
    end
  end
end
