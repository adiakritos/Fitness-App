class Meal < ActiveRecord::Base
  has_and_belongs_to_many :meal_foods
  # attr_accessible :title, :body
end
