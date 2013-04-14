class Food < ActiveRecord::Base
  attr_accessible :brand, 
                  :carbs, 
                  :fat, 
                  :name, 
                  :protien, 
                  :type
                          
  # def self.inherited(child)  
  #  child.instance_eval do
  #    def model_name
  #      Food.model_name
  #    end
  #  end
  #  super 
  #end
  
end
