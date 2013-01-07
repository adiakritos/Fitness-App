class RenameCutRateFromUsers < ActiveRecord::Migration
  def up
    change_table :users do |t|
      t.rename :cut_rate, :deficit_pct
    end
  end

  def down
  end
end
