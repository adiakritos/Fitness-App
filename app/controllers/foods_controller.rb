class FoodsController < ApplicationController
  before_filter :user_signed_in?
  #functions
  def create
    @meal_id = params[:meal_id]
    @new_food = params[:new_food_name]
    @site_food = SiteFood.find_by_name(params[:food_name])
    @custom_food = current_user.custom_foods.find_by_name(params[:food_name])
    @meal = current_user.meals.find_by_id(@meal_id) 

    # if custom_food exists?
    # use custom_food to create meal_food
    if !@custom_food.nil?
      
      if @meal.nil?
        flash[:error] = "#{@meal_id}"
      else
        @meal_food = @meal.meal_foods.build(name:         @custom_food.name, 
                                            brand:        @custom_food.brand,
                                            amount:       @custom_food.amount,
                                            fat:          @custom_food.fat,
                                            carbs:        @custom_food.carbs,
                                            protien:      @custom_food.protien,
                                            measure_type: @custom_food.measure_type)

        @meal_food.save!
      end  
      respond_to do |format|
        format.html {redirect_to meal_path(current_user.id)}
        format.js
      end
    end

    #if custom_food doesn't exist but site_food DOES
    if @custom_food.nil? & !@site_food.nil?
     #create custom_food and meal_food
      
      @meal_food = @meal.meal_foods.build(name:         @site_food.name,
                                          brand:        @site_food.brand,
                                          amount:       @site_food.amount,
                                          fat:          @site_food.fat,
                                          carbs:        @site_food.carbs,
                                          protien:      @site_food.protien,
                                          measure_type: @site_food.measure_type)
      @meal_food.save!

      @custom_food = current_user.custom_foods.build(name:         @site_food.name,
                                                     brand:        @site_food.brand,
                                                     amount:       @site_food.amount,
                                                     fat:          @site_food.fat,
                                                     carbs:        @site_food.carbs,
                                                     protien:      @site_food.protien,
                                                     measure_type: @site_food.measure_type) 
      @custom_food.save!  

      respond_to do |format|
        format.html {redirect_to meal_path(current_user.id)}
        format.js
      end


    #if neither custom_food nor site_food exists
    elsif @custom_food.nil? & @site_food.nil?
    #Render modal box to capture food info
      if @new_food.nil?

        respond_to do |format|
          format.html {redirect_to meal_path(current_user.id)}
          format.js
        end 

    #When user submits the modal box 
      elsif !@new_food.nil?
        @meal_food = @meal.meal_foods.build(name:         params[:new_food_name],
                                            brand:        params[:new_food_brand],
                                            amount:       params[:new_food_amount],
                                            fat:          params[:new_food_fat],
                                            carbs:        params[:new_food_carbs],
                                            protien:      params[:new_food_protien],
                                            measure_type: params[:new_food_measure_type])

        @custom_food = current_user.custom_foods.build(name:         params[:new_food_name],
                                                       brand:        params[:new_food_brand],
                                                       amount:       params[:new_food_amount],
                                                       fat:          params[:new_food_fat],
                                                       carbs:        params[:new_food_carbs],
                                                       protien:      params[:new_food_protien],
                                                       measure_type: params[:new_food_measure_type])  
        if @meal_food.valid? & @custom_food.valid?
          @meal_food.save!
          @custom_food.save!  
        else
          flash[:error] = "Error creating food: Make sure name, brand, and measure-types are included. All amounts are numbers and can only be written to a single decimal place. Ex: 10.4"
        end

        respond_to do |format|
          format.html {redirect_to meal_path(current_user.id)}
          format.js
        end        

      else
        flash[:error] = @meal_food.errors
      end
    end
  end

  def destroy
    @meal_food = current_user.meal_foods.find(params[:id])
    @meal_food.destroy
    respond_to do |format|
      format.html {redirect_to meal_path(current_user.id)}
      format.js
    end 

  end
   
  def search
    @user = current_user
    #@foods = Food.order(:name).where("name like? AND type = ? AND user_id = ? OR type = ?",
    #                               "%#{params[:term]}%", "CustomFood", current_user.id, "SiteFood").limit(4)
    # I want the customfoods where their id matches the users, and all the sitefoods
    @foods = Food.order(:name).where("name like ?", "%#{params[:term]}%" ).where("user_id = ? OR type = ?", current_user.id, "SiteFood").limit(3)
    render json: @foods.map{|t| {label: t.name, type: t.type}}
  end

  def new
    @meal = current_user.meals.find_by_id(params[:meal_id])
  end
  
end
