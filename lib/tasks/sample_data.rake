namespace :db do 
  desc  "Fill database with sample data"
  task populate: :environment do

    5.times do |n|
      email = "example-#{n+1}@railstutorial.org"
      password  = "foobar"
      User.create!(email: email,
                   password: password,
                   password_confirmation: password)
    end


    users = User.all(limit:6)

    #Creating Test Status Updates
    15.times do |n|
      weight = 200 - n
      bf_pct = 19 - n - 0.5
      users.each  do |user|
        user.status_update.create!(current_weight:weight,
                                   current_bf_pct: bf_pct )
      end
    end


    #Create Test Meals
    
    users.each do |user|
        3.times do |n|
        name = "Meal: #{n}" 
        user.meals.create!(meal_name: name)
      end
    end


    #Create Test Foods for users
      
    users.each do |user|
        user.meals.each do |meal|
          2.times do |n|
            name = "A food"
            meal.meal_foods.create!(name:name)
          end
        end

        3.times do |n|
          name = "A food"
          user.custom_foods.create!(name:name)
        end
    end

    10.times do |food|
      name = "Apple #{food}"
      SiteFood.create(name: name)
    end

  end
end
