class AddDetailsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :measurement, :string
    add_column :users, :bmr_formula, :string
    add_column :users, :fat_factor, :float
    add_column :users, :protein_factor, :float
  end
end
