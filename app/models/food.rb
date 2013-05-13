class Food < ActiveRecord::Base
   attr_accessible :name, :amount, :measure_type, :brand, :fat, :carbs, :protien

  validates :name,         presence: true, length: { in: 2..15 }
  validates :brand,        presence: true, length: { in: 1..15 }
  validates :amount,       presence: true, numericality: {:only_integer => true}, length: { in: 4..5 }
  validates :measure_type, presence: true, length: { in: 2..10 }
  validates :fat,          presence: true, numericality: {:only_integer => true}, length: { in: 4..5 }
  validates :carbs,        presence: true, numericality: {:only_integer => true}, length: { in: 4..5 } 
  validates :protien,      presence: true, numericality: {:only_integer => true}, length: { in: 4..5 }
                          
  # def self.inherited(child)  
  #  child.instance_eval do
  #    def model_name
  #      Food.model_name
  #    end
  #  end
  #  super 
  #end
  
end
