class FoodsController < ApplicationController
  before_filter :user_signed_in?
  #functions
  def create
    @meal_id = params[:meal_id]
    @food_name = params[:food_name]
    @custom_food = current_user.custom_foods.find_by_name(params[:food_name])

    if !@custom_food.nil?
      save_as_meal_food(@food_name, @meal_id) 
      redirect_to meal_path(current_user.id)
    end

    if @custom_food.nil?
      save_as_meal_food(@food_name, @meal_id)
      save_as_custom_food(@food_name) 
      redirect_to meal_path(current_user.id)
    end

  end

  def destroy
    @meal_food = current_user.meal_foods.find(params[:id])
    @meal_food.destroy
    redirect_to meal_path(current_user.id)
  end
   
  def search
    @user = current_user
    @foods = Food.order(:name).where("type = ? AND user_id = ? OR type = ?",
                                     "CustomFood", current_user.id, "SiteFood").limit(8)

    render json: @foods.map{|t| {label: t.name, type: t.type}}
  end
  
  def save_selected

  end

  def save_as_custom_food(food_name)
    @custom_food = current_user.custom_foods.build(name: food_name)
     @custom_food.save!
  end

  def save_as_meal_food(food_name, meal_id)
    @meal = current_user.meals.find_by_id(meal_id)
    if @meal.nil?
      flash[:error] = "#{meal_id}"
    else
      @meal_food = @meal.meal_foods.build(name: food_name)
      @meal_food.save!
    end
  end  
end
