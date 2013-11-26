namespace :db do 
  desc  "Fill database with sample data"
  task populate: :environment do
#
#   100.times do |n|
#     email = "#{n+1}@foobar.com"
#     password  = "foobar"
#     User.create!(email: email,
#                  password: password,
#                  password_confirmation: password)
#     puts "Created #{n + 1} Users"
#   end
#
#
#   #users = User.all(limit:6)
#   users = User.all
#
#   #Creating Test Status Updates
#   users.each do |user|
#
#    19.times do |n|
#     weight = 200 - n
#     bf_pct = 19 - n - 0.5
#     user.status_updates.create!(current_weight: weight,
#                                current_bf_pct: bf_pct,
#                                temporary: 'false')
#    end
#
#   #Create Test Meals
#   
#    6.times do |n|
#      name = "Meal: #{n}" 
#      user.meals.create!(meal_name: name)
#    end
#
#
#   #Create Test Foods for users
#    @name         = "A food"
#    @brand        = "Generic"
#    @serving_size = 1.5
#    @measure_type = 'oz'
#    @fat          = 10
#    @protein      = 45
#    @carbs        = 5
#
#     user.meals.each do |meal|
#       2.times do |n|
#         name = "A food"
#         meal.meal_foods.create!(name:@name,
#                                 brand:@brand,
#                                 serving_size:@serving_size,
#                                 measure_type:@measure_type,
#                                 fat:         @fat,
#                                 protein:     @protein,
#                                 carbs:       @carbs)
#       end
#     end
#
#     3.times do |n|
#       user.custom_foods.create!(name:@name,               
#                                 brand:@brand,
#                                 serving_size:@serving_size,
#                                 measure_type:@measure_type,
#                                 fat:         @fat,         
#                                 protein:     @protein,     
#                                 carbs:       @carbs)       
#                                 
#     end
#
#     5.times do |food|
#       name = "Apple #{food}"
#       SiteFood.create(name:@name,               
#                       brand:@brand,
#                       serving_size:@serving_size,
#                       measure_type:@measure_type,
#                       fat:         @fat,         
#                       protein:     @protein,     
#                       carbs:       @carbs)       
#     end
#   puts "Populated User #{user.id}"
#   end
#
 end
end
