class Food < ActiveRecord::Base
  attr_accessible :brand, :carbs, :fat, :name, :protien, :type
end
