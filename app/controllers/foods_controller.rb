class FoodsController < ApplicationController
  before_filter :user_signed_in?
  #functions
  def create
    @meal_id = params[:meal_id]
    @food_name = params[:food_name]
    @site_food = SiteFood.find_by_name(params[:food_name])
    @custom_food = current_user.custom_foods.find_by_name(params[:food_name])
    @meal = current_user.meals.find_by_id(@meal_id) 

    # if custom_food exists?
    # use custom_food to create meal_food
    if !@custom_food.nil?
      
      if @meal.nil?
        flash[:error] = "#{@meal_id}"
      else
        @meal_food = @meal.meal_foods.build(name:         @custom_food.name, 
                                            amount:       @custom_food.amount,
                                            fat:          @custom_food.fat,
                                            carbs:        @custom_food.carbs,
                                            protien:      @custom_food.protien,
                                            measure_type: @custom_food.measure_type)

        @meal_food.save!
      end  
      respond_to do |format|
        format.html { redirect_to meal_path(current_user.id)}
        format.js
      end
    end

    #if custom_food NOR site_foods exist 
    if @custom_food.nil? & @site_food.nil?
    #create custom_food and meal_food with default values and then send popup box for user to update the food. 
       
    #if food in "cancelled" then delete that food
    #create custom and meal foods based on user input
    #OTHERWISE
      else
    #create both a custom_food and meal_food based on site_food info
      @meal_food = @meal.meal_foods.build(name:         @site_food.name,
                                          amount:       @site_food.amount,
                                          fat:          @site_food.fat,
                                          carbs:        @site_food.carbs,
                                          protien:      @site_food.protien,
                                          measure_type: @site_food.measure_type)
      @meal_food.save!

      @custom_food = current_user.custom_foods.build(name:         @site_food.name,
                                                     amount:       @site_food.amount,
                                                     fat:          @site_food.fat,
                                                     carbs:        @site_food.carbs,
                                                     protien:      @site_food.protien,
                                                     measure_type: @site_food.measure_type) 
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
