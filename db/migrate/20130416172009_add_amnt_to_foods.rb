class AddAmntToFoods < ActiveRecord::Migration
  def change
    add_column :foods, :amount, :float
  end
end
