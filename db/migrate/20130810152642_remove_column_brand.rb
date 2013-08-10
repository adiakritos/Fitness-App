class RemoveColumnBrand < ActiveRecord::Migration
  def up
    change_table :foods do |t|
      t.remove :brand
    end
  end

  def down
  end
end
