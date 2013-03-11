FactoryGirl.define do
  factory :runkeeper_token do
    token 'deadbeef'
    user
  end
end
