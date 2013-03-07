module StatusUpdatesHelper

# Inputs Needed
  # target_bf_pct
  # activity_factor
  # deficit_pct
 
 def bmr(lbm) 
   lbm *= 0.45
   return '%.2f' % (370 + (21.6*lbm.to_d))
 end

 def target_weight(total_weight, target_bf_pct, lbm)
   return '%.2f' %  ((total_weight*target_bf_pct)+lbm)
 end

 def fat_to_burn(total_weight, target_weight)
   return '%.2f' % (total_weight.to_d - target_weight.to_d)
 end

 def tdee(bmr, activity_factor)
    return '%.2f' % (bmr.to_d*activity_factor.to_d)
 end

 def daily_calorie_target(tdee, deficit_pct)
    return '%.2f' % (tdee.to_d * deficit_pct.to_d)  
 end

 def weekly_burn_rate(tdee, daily_calorie_target)
    return '%.2f' % (daily_calorie_target.to_d*7) 
 end

 def time_to_goal(weekly_burn_rate, fat_to_burn)
   return '%.2f' %  (fat_to_burn.to_d*3500/weekly_burn_rate.to_d) 
 end



end   
