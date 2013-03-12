class ChangeUsersTable < ActiveRecord::Migration
  def up
    change_table :users do |t|
      t.rename :deficit_pct, :deficit_amnt
    end
  end

  def down
  end
end
