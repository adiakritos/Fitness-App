class SiteFood < Food

  attr_accessible :name, :amount, :measure_type, :brand, :fat, :carbs, :protien
  validates :name, presence: true, uniqueness: true
  validates :amount, presence: true
  validates :measure_type, presence: true
  validates :fat, presence: true
  validates :carbs, presence: true
  validates :protien, presence: true
  validates :brand, presence: true

end
