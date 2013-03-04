class WithingsController < ApplicationController
  def notify
    User.joins(:withings).where('consumer_tokens.withings_user_id' => params[:userid]).each do |user|
      withings_user = Withings::User.authenticate(user.withings.withings_user_id, user.withings.token, user.withings.secret)
      withings_user.measurement_groups(start_at: Time.at(params[:startdate].to_i), end_at: Time.at(params[:enddate].to_i))

      client = Liftapp::Client.new(user.email, user.lift_password)
      user.habit_links.each do |habit_link|
        client.checkin(habit_link.habit_id)
      end
    end
    render nothing: true  
  end
end
