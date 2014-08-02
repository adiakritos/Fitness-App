require 'csv'
class Food < ActiveRecord::Base

  def self.import(file)
    CSV.foreach(file.path, headers: :true) do |row|
      self.create! row.to_hash
    end
  end

end
