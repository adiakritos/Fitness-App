class AddDynamicServingSizeToFoods < ActiveRecord::Migration
  def change
    add_column :foods, :dynamic_serving_size, :float
  end
end
