class HabitLink < ActiveRecord::Base
  GITHUB_PUBLIC_COMMIT  = 1
  WITHINGS_SCALE        = 2
  GITHUB_PRIVATE_COMMIT = 3

  attr_accessible :habit_id, :user_id, :trigger

  validates :trigger, inclusion: {in: [GITHUB_PUBLIC_COMMIT, WITHINGS_SCALE]}

  belongs_to :user

  def self.update_github
    
  end
end
