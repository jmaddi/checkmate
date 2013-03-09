FactoryGirl.define do
  factory :habit_link do
    user
    habit_id 42
    trigger HabitLink::GITHUB_PUBLIC_COMMIT
  end
end
