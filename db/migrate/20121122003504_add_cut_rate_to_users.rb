class AddCutRateToUsers < ActiveRecord::Migration
  def change
    add_column :users, :cut_rate, :float
  end
end
