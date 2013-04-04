class MealFood < Food
  has_and_belongs_to_many :meals
end
