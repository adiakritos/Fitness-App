require 'rubygems' 
class MealsController < ApplicationController
  include StatusUpdatesHelper
  before_filter :correct_user, only: [:create, :update, :destroy]
  before_filter :user_signed_in?
  # Pages
  def show
    @user = User.find(params[:id])
    @meals = @user.meals
  end

  # Functions

  def new
    @meal = current_user.meals.build
    @meal.save
    respond_to do |format|
      format.html {redirect_to meal_path(current_user.id)}
      format.js
    end
  end

  def update

  end

  def destroy
    @id = params[:id].to_i
    @meal = current_user.meals.find(@id)
    @meal.destroy
    respond_to do |format|
      format.html {redirect_to meal_path(current_user.id)}
      format.js
    end
  end

  private

  def correct_user
  
  
  end  
end
