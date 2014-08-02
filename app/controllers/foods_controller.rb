class FoodsController < ApplicationController

  def search
    @foods = Food.where("name LIKE ?", "%#{params[:query]}%").take(20).reverse
    render json: @foods.map{|t| t.name}
  end

  def import
    Food.import(params[:file])        
    redirect_to foods_path
  end

  private 

  def food_params
    params.require(:query).permit(
           :name,
           :type,
           :servings,
           :serving_size,
           :units,
           :glycemic_index,
           :saturated_fat,
           :polyunsaturated_fat,
           :monosaturated_fat,
           :trans_fat,
           :cholesterol,
           :vitamin_a,
           :vitamin_c,
           :sodium,
           :potassium,
           :dietary_fiber,
           :sugar,
           :protein,
           :calcium,
           :iron,
           :dynamic_carbs,
           :dynamic_protein,
           :dynamic_fat,
           :dynamic_sodium,
           :created_at,
           :updated_at
          ) 
  end                                                                    
end
