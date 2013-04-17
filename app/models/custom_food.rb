class CustomFood < Food

  attr_accessible :name, :amount, :measure_type, :brand, :fat, :carbs, :protien

  belongs_to :user

  validates :name,         uniqueness: true
  validates :amount,       presence: true
  validates :measure_type, presence: true
  validates :fat,          presence: true
  validates :carbs,        presence: true
  validates :protien,      presence: true

end                            
