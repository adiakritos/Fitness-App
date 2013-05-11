module StatusUpdatesHelper

  def bmr(lbm) 
    lbm *= 0.45
    return '%.2f' % (370 + (21.6 * lbm.to_d))
  end

  def target_weight(total_weight, target_bf_pct, lbm)
    target_bf_pct /= 100
    return '%.2f' %  ((total_weight*target_bf_pct)+lbm)
  end 

  def fat_to_burn(total_weight, target_weight)
    return '%.2f' % (total_weight.to_d - target_weight.to_d)
  end

  def tdee(bmr, activity_factor)
    return '%.2f' % (bmr.to_d*activity_factor.to_d)
  end

  def deficit_pct(deficit_amnt, tdee)
    daily_cal_def = ((deficit_amnt.to_f * 3500)/7)
    return (daily_cal_def.to_d/tdee.to_d)
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

  def daily_intake( tdee, daily_calorie_target )
    return '%.2f' % (tdee.to_d - daily_calorie_target.to_d)
  end


  def total_progress
    if user_signed_in?
      if current_user.status_update.empty?
        @total_weight_change = 0
        @total_fat_change = 0
        @total_lbm_change = 0

        @time_to_goal = 0
        @fat_to_burn = 0
        @target_bf_pct = 0
        @lbm             = 0
        @activity_factor = 0
        @bmr             = 0
        @total_weight    = 0
        @target_weight   = 0
        @fat_to_burn     = 0
        @tdee            = 0
        @deficit_amnt    = 0
        @deficit_pct     = 0
        @daily_calorie_target = 0
        @daily_intake         = 0
        @weekly_burn_rate     = 0
        @time_to_goal         = 0

        @current_weight       = 0
        @current_bf_pct       = 0
        @current_lbm          = 0
        @current_fat_weight   = 0

        @daily_caloric_deficit = 0
      end

      if current_user.status_update.any?
        
        @first = current_user.status_update.first

        @last  = current_user.status_update.last

        @beginning_date       = current_user.status_update
                               .first.created_at.strftime("%m/%d/%Y")
        @last_date            = current_user.status_update
                               .last.created_at.strftime("%m/%d/%Y")
        @total_weight_change  = BigDecimal(@first.current_weight - 
                                           @last.current_weight, 3)
        @total_fat_change     = BigDecimal(@first.current_fat_weight - 
                                           @last.current_fat_weight, 3)
        @total_lbm_change     = BigDecimal(@first.current_lbm - 
                                           @last.current_lbm, 3)
        @recent_fat_change    = BigDecimal(@first.current_fat_weight -
                                           @first.previous_status_update.current_fat_weight, 3)
        @recent_lbm_change    = BigDecimal(@first.current_lbm -
                                           @first.previous_status_update.current_lbm, 2)
        @recent_weight_change = BigDecimal(@first.current_weight -
                                           @first.previous_status_update.current_weight, 2) 
        @lbm                  = @first.current_lbm
        @activity_factor      = current_user.activity_factor
        @bmr                  = bmr(@lbm)
        @total_weight         = @first.current_weight
        @target_bf_pct        = (current_user.target_bf_pct) 
        @target_weight        = target_weight(@total_weight, @target_bf_pct, @lbm)
        @fat_to_burn          = fat_to_burn(@total_weight, @target_weight)
        @tdee                 = tdee(@bmr, @activity_factor)
        @deficit_amnt         = current_user.deficit_amnt
        @deficit_pct          = deficit_pct(@deficit_amnt, @tdee)
        @daily_calorie_target = daily_calorie_target(@tdee, @deficit_pct)
        @daily_intake         = daily_intake(@tdee, @daily_calorie_target)
        @weekly_burn_rate     = weekly_burn_rate(@tdee, @daily_calorie_target)
        @time_to_goal         = time_to_goal(@weekly_burn_rate, @fat_to_burn)
        @current_weight       = BigDecimal(@first.current_weight, 4)
        @current_bf_pct       = BigDecimal(@first.current_bf_pct * 100, 4)
        @current_lbm          = BigDecimal(@first.current_lbm, 4)
        @current_fat_weight   = BigDecimal(@first.current_fat_weight, 4)
        @daily_caloric_deficit = @tdee.to_d - @daily_intake.to_d
        #End Date
        @start_date           = current_user.status_update.first.created_at
        @end_date             = (@start_date + @time_to_goal.to_i.weeks).strftime("%m/%d/%Y")
      end           
    end
  end

  def pct_carbs_satisfied
     #how many carbs are needed?
     #cals_needed = @tdee.to_i * (1 - @deficit_pct.to_f)
     #carbs_needed = cals_needed * 4
     #how many carbs are provided?
     #carbs_provided = total_of(:carbs)
     #what is the pct satisfied?
     # pct_fulfilled = carbs_provided.to_f/carbs_needed.to_f
     return 
  end                         




end   
