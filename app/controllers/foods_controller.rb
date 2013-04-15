class FoodsController < ApplicationController
  before_filter :user_signed_in?
  #functions
  def create
    @meal_id = params[:meal_id]
    @food_name = params[:food_name]
    @custom_food = current_user.custom_foods.find_by_name(params[:food_name])
    @meal = current_user.meals.find_by_id(@meal_id) 

    if !@custom_food.nil?
      
      if @meal.nil?
        flash[:error] = "#{@meal_id}"
      else
        @meal_food = @meal.meal_foods.build(name: @food_name)
        @meal_food.save!
      end  
      respond_to do |format|
        format.html { redirect_to meal_path(current_user.id)}
        format.js
      end
    end

    if @custom_food.nil?
      if @meal.nil?
        flash[:error] = "#{@meal_id}"
      else
        @meal_food = @meal.meal_foods.build(name: @food_name)
        @meal_food.save!
      end 

      @custom_food = current_user.custom_foods.build(name: @food_name)
      @custom_food.save!  
      respond_to do |format|
        format.html { redirect_to meal_path(current_user.id)}
        format.js
      end
    end

  end

  def destroy
    @meal_food = current_user.meal_foods.find(params[:id])
    @meal_food.destroy
    respond_to do |format|
      format.html { redirect_to meal_path(current_user.id)}
      format.js
    end 

  end
   
  def search
    @user = current_user
    #@foods = Food.order(:name).where("name like? AND type = ? AND user_id = ? OR type = ?",
    #                               "%#{params[:term]}%", "CustomFood", current_user.id, "SiteFood").limit(4)
    # I want the customfoods where their id matches the users, and all the sitefoods
    @foods = Food.order(:name).where("name like ?", "%#{params[:term]}%" ).where("user_id = ? OR type = ?", current_user.id, "SiteFood").limit(3)
    render json: @foods.map{|t| {label: t.name, type: t.type}}
  end

  def new
    @meal = current_user.meals.find_by_id(params[:meal_id])
  end
  
end
