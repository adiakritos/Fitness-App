class ChangeServingsType < ActiveRecord::Migration
  def up
    change_column :foods, :servings, :float
  end

  def down
    change_column :foods, :servings, :integer
  end
end
