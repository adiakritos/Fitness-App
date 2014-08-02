class MealFoodsController < FoodsController

  def create
    @food_names = params[:foods]
    @meal_id = params[:meal_id]
    @meal = Meal.where(id: @meal_id).first
    
    @food_names.each do |f|
      @original_food = Food.where(name: f).first
      @meal.meal_foods.create(  
            name:                 @original_food.name,
            servings:             @original_food.servings,
            serving_size:         @original_food.serving_size,
            units:                @original_food.units,
            glycemic_index:       @original_food.glycemic_index,
            carbs:                @original_food.carbs,
            protein:              @original_food.protein,
            fat:                  @original_food.fat,
            saturated_fat:        @original_food.saturated_fat,
            polyunsaturated_fat:  @original_food.polyunsaturated_fat,
            monosaturated_fat:    @original_food.monosaturated_fat,
            trans_fat:            @original_food.trans_fat,
            cholesterol:          @original_food.cholesterol,
            vitamin_a:            @original_food.vitamin_a,
            vitamin_c:            @original_food.vitamin_c,
            sodium:               @original_food.sodium,
            potassium:            @original_food.potassium,
            dietary_fiber:        @original_food.dietary_fiber,
            sugar:                @original_food.sugar,
            calcium:              @original_food.calcium,
            iron:                 @original_food.iron,
            dynamic_carbs:        @original_food.dynamic_carbs,
            dynamic_protein:      @original_food.dynamic_protein,
            dynamic_fat:          @original_food.dynamic_fat,
            dynamic_sodium:       @original_food.sodium
          )
      @meal.save
    end

    redirect_to :back
  end

  def destroy
    @id = params[:id].to_i
    @meal_food = MealFood.find(@id)
    @meal_food.destroy
    redirect_to :back
  end

  def update
    @meal_food = MealFood.find(params[:id])
    @servings = meal_food_params[:servings]

    @meal_food.update(servings: @servings)
    redirect_to :back
  end

  private 

  def meal_food_params
    params.require(:meal_food).permit(:servings) 
  end                                                                    


end
