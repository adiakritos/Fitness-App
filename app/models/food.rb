class Food < ActiveRecord::Base
  
  before_create :set_defaults
  before_update :update_macros

  attr_accessible :name, 
                  :servings, 
                  :serving_size, 
                  :measure_type, 
                  :fat, 
                  :carbs, 
                  :protien, 
                  :dynamic_fat, 
                  :dynamic_protien, 
                  :dynamic_carbs

  validates :name,             presence: true
  validates :serving_size,     presence: true
  validates :measure_type,     presence: true
  validates :fat,              presence: true
  validates :carbs,            presence: true
  validates :protien,          presence: true
  validates :servings,         presence: true, on: :update
  validates :dynamic_carbs,    presence: true, on: :update
  validates :dynamic_fat,      presence: true, on: :update
  validates :dynamic_protien,  presence: true, on: :update

  def set_defaults
    self.servings = 1
    self.dynamic_protien = self.protien 
    self.dynamic_carbs   = self.carbs 
    self.dynamic_fat     = self.fat 
    self.dynamic_serving_size = self.serving_size
  end

  def update_macros
    @servings = self.servings
    self.dynamic_fat     = round(self.fat * @servings)
    self.dynamic_protien = round(self.protien * @servings)
    self.dynamic_carbs   = round(self.carbs * @servings)
    self.dynamic_serving_size = round(self.serving_size * @servings)
  end

  def round( input )
    '%.3f' % input
  end

end
