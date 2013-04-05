class MealsController < ApplicationController

  # Pages
  def show
   @user = User.find(params[:id])
   @meals = @user.meal
  end

  # Functions
  def create
   @meal = current_user.meal.build

    if @meal.save
      flash[:success] = "Meal Saved!"
      redirect_to meal_path(current_user.id)
    else
      flash[:error] = "Couldn't Create Meal"
      redirect_to meal_path(current_user.id)
    end 
  end
  
  def update

  end

  def destroy
    
  end

  
end
