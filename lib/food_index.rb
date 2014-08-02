
class FoodIndex
  def init
    
  end

  def go
  require 'csv'
    CSV.open("PrimaryFoodList.csv", "w", headers:true) do |csv|
      foods = GlobalFood.all
      foods.each do |f|
        csv << [f.name, f.type, f.brand, f.servings, f.serving_size, f.units, f.carbs, f.protein, f.fat, f.saturated_fat, f.polyunsaturated_fat, f.monosaturated_fat, f.trans_fat, f.cholesterol, f.vitamin_a, f.vitamin_c, f.sodium, f.potassium, f.dietary_fiber, f.sugar, f.calcium, f.iron]   
        puts f.id
      end
    end
  end
end
