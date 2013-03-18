class PagesController < ApplicationController
  def index
    if user_signed_in?
      @services = [
        {
          name: 'Withings',
          path: oauth_consumer_path(:withings),
          image: '/assets/withings.png',
          connected: !current_user.withings.nil?
        },
        {
          name: 'Github',
          path: oauth_consumer_path(:github),
          image: '/assets/github.png',
          connected: !current_user.github.nil?
        },
        {
          name: 'Runkeeper',
          path: oauth_consumer_path(:runkeeper),
          image: '/assets/runkeeper.jpg',
          connected: !current_user.runkeeper.nil?
        }
      ]
      @triggers = [
        {
          label: 'Weigh myself',
          id: HabitLink::WITHINGS_SCALE,
          enabled: !current_user.withings.nil?
        },
        {
          label: 'Push to a Github public repository',
          id: HabitLink::GITHUB_PUBLIC_COMMIT,
          enabled: !current_user.github.nil?
        },
        {
          label: 'Complete a new run',
          id: HabitLink::RUNKEEPER_RUN,
          enabled: !current_user.runkeeper.nil?
        }
      ]
    end
  end
end
