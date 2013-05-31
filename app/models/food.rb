class Food < ActiveRecord::Base
  after_initialize :default_values

  attr_accessible :name, :amount, :measure_type, :brand, :fat, :carbs, :protien

  validates :name,         presence: true
  validates :brand,        presence: true
  validates :amount,       presence: true
  validates :measure_type, presence: true
  validates :fat,          presence: true
  validates :carbs,        presence: true
  validates :protien,      presence: true

  def default_values
    self.name         = 'default food name'
    self.brand        = 'default food brand'
    self.amount       = 0
    self.measure_type = 'oz'
    self.fat          = 0
    self.carbs        = 0
    self.protien      = 0
  end
  
  
end
