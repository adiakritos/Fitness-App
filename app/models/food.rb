class Food < ActiveRecord::Base
   attr_accessible :name, :amount, :measure_type, :brand, :fat, :carbs, :protien

  validates :name,         presence: true
  validates :brand,        presence: true
  validates :amount,       presence: true
  validates :measure_type, presence: true
  validates :fat,          presence: true
  validates :carbs,        presence: true
  validates :protien,      presence: true
                          
  # def self.inherited(child)  
  #  child.instance_eval do
  #    def model_name
  #      Food.model_name
  #    end
  #  end
  #  super 
  #end
  
end
