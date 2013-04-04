class Meal < ActiveRecord::Base
  before_save :sanitize
  has_and_belongs_to_many :meal_foods
  # attr_accessible :title, :body
  attr_accessible :meal_name

  def sanitize
    self.meal_name = "Meal"
  end
end
