class HabitLink < ActiveRecord::Base
  GITHUB_PUBLIC_COMMIT  = 1
  WITHINGS_SCALE        = 2
  GITHUB_PRIVATE_COMMIT = 3
  RUNKEEPER_RUN         = 4

  attr_accessible :habit_id, :user_id, :trigger

  validates :trigger, inclusion: {in: [GITHUB_PUBLIC_COMMIT, WITHINGS_SCALE, RUNKEEPER_RUN]}

  belongs_to :user

  def self.update_runkeeper
    where(trigger: RUNKEEPER_RUN).each do |habit_link|
      user = HealthGraph::User.new(habit_link.user.runkeeper.token)
      activities = user.fitness_activities
      runs = activities.items.select do |activity|
        activity.type == 'Running' &&
        activity.start_time.to_datetime > Time.new.beginning_of_day.to_datetime
      end

      if runs.length > 0
        user = habit_link.user
        client = Liftapp::Client.new(user.email, user.lift_password)
        client.checkin(habit_link.habit_id)
      end
    end
    # activities.items.first.start_time.to_datetime
  end

  def self.update_github
    where(trigger: GITHUB_PUBLIC_COMMIT).each do |habit_link|
      events = Octokit.user_events('jmaddi')
      pushes = events.select do |event|
        event.type == 'PushEvent' &&
        event.created_at.to_datetime > Time.new.beginning_of_day.to_datetime
      end
      if (pushes.length > 0)
        user = habit_link.user
        client = Liftapp::Client.new(user.email, user.lift_password)
        client.checkin(habit_link.habit_id)
      end
    end
  end
end
