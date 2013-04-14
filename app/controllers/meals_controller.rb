require 'rubygems' 
class MealsController < ApplicationController
  before_filter :correct_user, only: [:create, :update, :destroy]
  before_filter :user_signed_in?
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
    @id = params[:id].to_i
    @meal = current_user.meals.find(@id)
    @meal.destroy
    redirect_to meal_path(current_user.id)
  end

  private

  def correct_user
  
  
  end  
end
