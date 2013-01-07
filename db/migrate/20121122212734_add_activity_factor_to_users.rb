class AddActivityFactorToUsers < ActiveRecord::Migration
  def change
    add_column :users, :activity_factor, :float
  end
end
