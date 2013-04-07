class MealsController < ApplicationController

  # Pages
  def show
   @user = User.find(params[:id])
   @meals = @user.meals
  end

  # Functions
  def create
   @meal = current_user.meals.build

    if @meal.save
      redirect_to meal_path(current_user.id)
    else
      flash[:error] = "Couldn't Create Meal"
      redirect_to meal_path(current_user.id)
    end 
  end
  
  def update

  end

  def destroy
    @meal = Meal.find(params[:id])
    @meal.destroy
    redirect_to meal_path(current_user.id)
  end


  private

  def create_meal


  end

  
end
