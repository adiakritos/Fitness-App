class DropServingAndAmountFromFoods < ActiveRecord::Migration
  def up
    def change
      remove_column :foods, :serving
      remove_column :foods, :amount
      add_column    :foods, :serving_size, :float
      add_column    :foods, :servings,     :float
    end
  end

  def down
  end
end
