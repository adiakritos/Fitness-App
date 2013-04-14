class CustomFood < Food
  belongs_to :user
  validates :name, uniqueness: true
end                            
