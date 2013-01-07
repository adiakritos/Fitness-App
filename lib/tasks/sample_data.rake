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
    15.times do |n|
      weight = 200 - n
      bf_pct = 19 - n - 0.5
      users.each  do |user|
        user.status_update.create!(current_weight:weight,
                                   current_bf_pct: bf_pct )
      end
    end
  end
end
