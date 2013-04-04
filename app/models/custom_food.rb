class CustomFood < Food
  belongs_to :user
  attr_accessible :user_id
end                            
