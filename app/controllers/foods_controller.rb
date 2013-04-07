class FoodsController < ApplicationController
  #functions
  def create

    @meal = current_user.meals.find_by_id(params[:id])
    @meal_food = @meal.meal_foods.create
    if @meal_food.save!
      redirect_to meal_path(current_user.id)
    else
      flash[:error] = "Food couldn't be created."
      redirect_to meal_path(current_user.id)
    end
  end



  def destroy
    @meal_food = MealFood.find(params[:id])
    @meal_food.destroy
    redirect_to meal_path(current_user.id)
  end
end
