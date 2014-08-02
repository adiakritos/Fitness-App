class Meal < ActiveRecord::Base
  belongs_to :client
  has_many :meal_foods 
end

