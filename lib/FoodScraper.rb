class FoodScraper

  def go
    @doc = Nokogiri::HTML(open("http://www.myfitnesspal.com/food/search?page=#{@page_number}&search=#{@search_string}"))

  end

  def update_search_string
    

  end

  def update_page
    @page_number += 1
  end

  def create_food

  end

  def validate_food

  end

end
