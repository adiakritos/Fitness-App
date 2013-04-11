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
   
  def search
    @user = current_user
    # type = CustomFood HAVING user_id = current_user.id
    #@foods = Food.order(:name).where("name like ?" , "%#{params[:term]}%").limit(8)
    @foods = Food.order(:name).where("type = ? AND user_id = ? OR type = ?",
                                     "CustomFood", current_user.id, "SiteFood").limit(8)

    render json: @foods.map{|t| {label: t.name, type: t.type}}
  end
  
  def save_selected

  end
end
