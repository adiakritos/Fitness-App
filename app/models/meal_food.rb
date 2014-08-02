class MealFood < Food
   belongs_to :meal
   belongs_to :client

   before_save :set_macros
   before_update :set_macros

   def set_macros
     self.dynamic_fat     = self.fat     * self.servings
     self.dynamic_carbs   = self.carbs   * self.servings
     self.dynamic_protein = self.protein * self.servings
     self.dynamic_sodium  = self.sodium  * self.servings
   end

end

