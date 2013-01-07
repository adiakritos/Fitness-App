FactoryGirl.define do
  factory :user do 
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar" 
  end

  factory :status_update do
    user
    current_weight 150
    current_bf_pct 0.15
  end 
end
