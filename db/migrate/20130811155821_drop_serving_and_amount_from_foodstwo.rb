class DropServingAndAmountFromFoodstwo < ActiveRecord::Migration
  def up
    change_table :foods do |t|
      t.rename :serving, :servings
      t.rename :amount,  :serving_size
    end
  end

  def down
  end
end
