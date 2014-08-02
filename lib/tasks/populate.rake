namespace :db do
  desc "Fill in the databse with sample data"
  task :populate => :environment do
    require 'populator'
    require 'faker'
    Rake::Task['db:reset'].invoke
    make_trainers
  end

  def make_trainers
    5.times do |n|
      email    = "t-#{n+1}@gmail.com"
      password = "foobarbaz"
      trainer  = Trainer.create!(email: email, password: password)
      puts "Created trainer number #{n+1}"
      make_clients(trainer, n)
    end
  end

  def make_clients(trainer, n)
    7.times do |c|
      firstname   = Faker::Name.first_name
      lastname    = Faker::Name.last_name
      status      = [true, false].sample
      email       = Faker::Internet.email
      client      = trainer.clients.create!(
        firstname: firstname, lastname: lastname, status: status, email: email)
      make_status_update(client, c)
      puts "Created client ##{c+1} for Trainer ##{n+1}"
    end
  end

  def make_status_update(client, c)
    3.times do |s|
      phase        = "B" 
      entry_date   = "10/0#{s+1}/1990"
      total_weight = "#{180-0.4*s}"
      body_fat_pct = "#{15-s*0.2}"
      the_client   = client
      client.status_updates.create!(
        client: the_client, phase: phase, entry_date: entry_date, 
        total_weight: total_weight, body_fat_pct: body_fat_pct)
      puts "Created status_update ##{s+1} for client ##{c+1}"
    end
  end

end

