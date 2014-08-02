require 'faker'

FactoryGirl.define do

  factory :trainer do
    email    "foobar@baz.com"
    password "foobarbaz"
  end

  factory :client do
    firstname       { Faker::Name.first_name }
    lastname        { Faker::Name.last_name }
    sequence(:email) { |n| "foobar#{n}@gmail.com" }
    fat_factor      0.4
    protein_factor  0.95
    activity_level  1.4
    target_calories 2100
    status          true
    trainer
  end

  factory :status_update do
    entry_date   "10/04/1990"
    phase        "bulk"
    total_weight  180
    body_fat_pct  12
    client
  end

  factory :food do
    name  { Faker::Food.name }
  end

end
