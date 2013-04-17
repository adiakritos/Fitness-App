class AddMeasureTypeToFoods < ActiveRecord::Migration
  def change
    add_column :foods, :measure_type, :string
  end
end
