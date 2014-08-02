class MealsController < ApplicationController

  def show
    @meals    = current_client.meals.includes(:meal_foods)    
    @meal = current_client.meals.build
  end

  def create
    @meal = current_client.meals.create(meal_params)
    if @meal.save
      flash[:success] = 'Saved'
      respond_to do |format|
       format.html { redirect_to :back }
       format.js
      end
    else
      flash[:notice] = 'Error'
      redirect_to :back
    end
  end

  def update
    @meal = current_client.meals.find(params[:id])
    @meal.update_attributes(meal_params)
    redirect_to :back
  end

  def destroy
    @id = params[:id].to_i
    @meal = current_client.meals.find(@id)
    @meal.destroy
    redirect_to :back
  end

  private

  def meal_params
    params.require(:meal).permit(:meal_name)
  end
end
