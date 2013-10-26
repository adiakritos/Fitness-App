class FoodScraper

  def go
    #url = "http://www.myfitnesspal.com/food/search?page=#{@page_number}&search=#{@search_string}"
    url = "http://www.myfitnesspal.com/food/search?page=1&search=a"
    @doc = Nokogiri::HTML(open(url))
    @foods = @doc.css(".food_info")

    foods.each do |food|
    
      food_description = food.at_css('.food_description')
      nutritional_info = food.at_css('.nutritional_info').text.squish
      #0 servings, 1 Calories, 2 fat, 3 carbs, 4 protein
      macros = nutritional_info.match(/Serving Size: (.+), Calories: (.+), Fat: (.+), Carbs: (.+), Protein: (.+)/)
      measures = nutritional_info.match(/Serving Size:\s*(?<servings>\d+)\s*(?<type>\w+)/)
     
      name          = food_description.first_element_child.text
      brand         = food_description.last_element_child.text
      servings      = measures['servings'].match(/.*(?<!g)/).to_s.to_f
      servings_type = measures['type']
      fat           = macros[3].match(/.*(?<!g)/).to_s.to_f
      carbs         = macros[4].match(/.*(?<!g)/).to_s.to_f
      protein       = macros[5].match(/.*(?<!g)/).to_s.to_f

      food_exists?(name, brand)
    #  @food = Food.build(name, brand, serving_size, serving_amount, fat, carbs, protien)
    #  if food_exists? == true
      #  do nothing
      # else
      #   create_food
      # end
    end

   #if next_page? == true
    #  @page += 1
    # else
    #  update_query
    #  @page = 1
    #end
  end

  def food_exists?(name, brand)
    SiteFood.find_by_name(name)


  end

  def next_page?
    
  end

  def update_query
    
  end

  def create_food

  end

end
