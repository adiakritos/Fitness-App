class Meal < ActiveRecord::Base
  before_save :sanitize
  has_many :meal_foods, dependent: :destroy
  attr_accessible :meal_name

  def sanitize
    self.meal_name = "Meal"
  end
end
