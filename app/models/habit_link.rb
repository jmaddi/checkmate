class HabitLink < ActiveRecord::Base
  attr_accessible :habit_id, :user_id

  belongs_to :user
end
