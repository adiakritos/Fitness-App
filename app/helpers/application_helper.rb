module ApplicationHelper
  
  def full_title(page_title)
    base_title = "Welcome to the Fitness App"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def bmr(lbm) 
    lbm *= 0.45
    return '%.2f' % (370 + (21.6 * lbm.to_d))
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

  def deficit_pct(deficit_amnt, tdee)
    daily_cal_def = ((deficit_amnt.to_d * 3500)/7)
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
    if current_user.status_update == nil
      @total_weight_change = 0
      @total_fat_change = 0
      @total_lbm_change = 0
      @goal = current_user.goal;
      @time_to_goal = nil;
      @fat_to_burn = nil;
      @target_bf_pct = 0;

    elsif

      @first = current_user.status_update.first
      @last  = current_user.status_update.last
      @beginning_date = current_user.status_update
                        .first.created_at.strftime("%m/%d/%Y")
      @last_date      = current_user.status_update
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
      @goal            = current_user.goal
      @lbm             = @first.current_lbm
      @activity_factor = current_user.activity_factor
      @bmr             = bmr(@lbm)
      @total_weight    = @first.current_weight
      @target_bf_pct   = (current_user.target_bf_pct) / 100
      @target_weight   = target_weight(@total_weight, @target_bf_pct, @lbm)
      @fat_to_burn     = fat_to_burn(@total_weight, @target_weight)
      @tdee            = tdee(@bmr, @activity_factor)
      @deficit_amnt    = current_user.deficit_amnt
      @deficit_pct     = deficit_pct(@deficit_amnt, @tdee)
      @daily_calorie_target = daily_calorie_target(@tdee, @deficit_pct)
      @daily_intake         = daily_intake(@tdee, @daily_calorie_target)
      @weekly_burn_rate     = weekly_burn_rate(@tdee, @daily_calorie_target)
      @time_to_goal         = time_to_goal(@weekly_burn_rate, @fat_to_burn)
      @current_weight       = BigDecimal(@first.current_weight, 4)
      @current_bf_pct       = BigDecimal(@first.current_bf_pct * 100, 4)
      @current_lbm          = BigDecimal(@first.current_lbm, 4)
      @current_fat_weight   = BigDecimal(@first.current_fat_weight, 4)
      #End Date
      @start_date           = current_user.status_update.first.created_at
      @end_date             = (@start_date + @time_to_goal.to_i.weeks).strftime("%m/%d/%Y")
    end           
  end
end

