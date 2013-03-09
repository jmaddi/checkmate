FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "test#{n}@test.com" }
    lift_password 'swordfish'
  end
end
