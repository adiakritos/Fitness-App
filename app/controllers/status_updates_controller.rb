class StatusUpdatesController < ApplicationController
  include StatusUpdatesHelper

  before_filter :correct_user, only: :destroy
  before_filter :total_progress, only: :new

  def create
    @status_update = current_user.status_update.build(params[:status_update])
    if @status_update.save
      flash[:success] = "Status Update Saved!"
     # redirect_to status_update_path(current_user.id)
      redirect_to new_status_update_path
    else
      flash[:error] = "Input Error - Couldn't Save Status Update"
      redirect_to new_status_update_path
    end 
  end 
  
  def new
      @status_update = current_user.status_update.build if user_signed_in?
  end

  def show
    @user = User.find(params[:id])
    @status_updates = @user.status_update
  end

  def destroy
    @status_update.destroy
    flash[:success] = "Status update deleted!"
    redirect_to status_update_path(current_user.id)
  end

  def delete_all
    @all_status_updates = current_user.status_update
    @all_status_updates.delete_all
    flash[:success] = "All status updates deleted!"
    redirect_to status_update_path(current_user.id)
  end

  private

  def correct_user
    @status_update = current_user.status_update.find_by_id(params[:id])
    redirect_to root_url if @status_update.nil?
  end 
  
  def total_progress
    if current_user.status_update == nil
      @total_weight_change = 0
      @total_fat_change = 0
      @total_lbm_change = 0
      @goal = current_user.goal;
      @time_to_goal = nil;
      @fat_to_burn = nil;
    elsif
      @first = current_user.status_update.first
      @last  = current_user.status_update.last
      @beginning_date = current_user.status_update
                        .first.created_at.strftime("%m/%d/%Y")
      @last_date      = current_user.status_update
                        .last.created_at.strftime("%m/%d/%Y")
      @total_weight_change = BigDecimal(@first.current_weight - 
                                        @last.current_weight, 3)
      @total_fat_change    = BigDecimal(@first.current_fat_weight - 
                                        @last.current_fat_weight, 3)
      @total_lbm_change    = BigDecimal(@first.current_lbm - 
                                        @last.current_lbm, 3)
      @goal            = current_user.goal
      @lbm             = @first.current_lbm
      @activity_factor = current_user.activity_factor
      @deficit_pct     = current_user.deficit_pct
      @bmr             = bmr(@lbm)
      @total_weight    = @first.current_weight
      @target_bf_pct   = current_user.target_bf_pct
      @target_weight   = target_weight(@total_weight, @target_bf_pct, @lbm)
      @fat_to_burn     = fat_to_burn(@total_weight, @target_weight)
      @tdee            = tdee(@bmr, @activity_factor)
      @deficit_pct     = current_user.deficit_pct
      @daily_calorie_target = daily_calorie_target(@tdee, @deficit_pct)
      @weekly_burn_rate     = weekly_burn_rate(@tdee, @daily_calorie_target)
      @time_to_goal         = time_to_goal(@weekly_burn_rate, @fat_to_burn)
      
    end
  end



end                                
