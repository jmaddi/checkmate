class HabitLink < ActiveRecord::Base
  GITHUB_PUBLIC_COMMIT  = 1
  WITHINGS_SCALE        = 2
  GITHUB_PRIVATE_COMMIT = 3

  attr_accessible :habit_id, :user_id, :trigger

  validates :trigger, inclusion: {in: [GITHUB_PUBLIC_COMMIT, WITHINGS_SCALE]}

  belongs_to :user

  def self.update_github
    where(trigger: GITHUB_PUBLIC_COMMIT).each do |habit_link|
      #client = Octokit::Client.new(oauth_token: user.github.token)
      events = Octokit::Client.user_events('jmaddi')
      events.select {|event| event.created_at.to_datetime > Time.new.beginning_of_day.to_datetime && event.type == 'PushEvent' }
      user = habit_link.user
      client = Liftapp::Client.new(user.email, user.lift_password)
      client.checkin(1337)
    end
  end
end
