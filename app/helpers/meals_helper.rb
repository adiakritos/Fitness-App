module MealsHelper
  def total_of(macro)
    current_user.meal_foods.map(&macro).inject(:+)
  end

  def pct_fat_satisfied
     #how much of a macro is needed?
     #  fat_needed = fat factor * current lbm
     fat_factor = current_user.fat_factor
     current_lbm = current_user.status_update.first.current_lbm
     fat_needed = fat_factor * current_lbm
     #how much is in the meal?
     fat_provided = total_of(:fat)
     #percent needed
     pct_fulfilled = fat_provided.to_f/fat_needed.to_f
     return BigDecimal(pct_fulfilled, 2)*100
  end     

  def pct_carbs_satisfied( tdee, deficit_pct )
     #how many carbs are needed?
     cals_needed = tdee.to_f * (1 - deficit_pct.to_f)
     carbs_needed = cals_needed * 4
     #how many carbs are provided?
     carbs_provided = total_of(:carbs)
     #what is the pct satisfied?
     pct_fulfilled = carbs_provided.to_f/carbs_needed.to_f
     return tdee 
  end  

  def pct_protein_satisfied
    #how much protien is needed?
    protein_factor = current_user.protein_factor 
    current_lbm = current_user.status_update.first.current_lbm
    protein_needed = protein_factor * current_lbm
    #how much protien is provided?
    protein_provided = total_of(:protien)
    #pct of protien satisfied?
    pct_fulfilled = protein_provided.to_f/protein_needed.to_f
    return BigDecimal(pct_fulfilled, 2)*100
  end

end
