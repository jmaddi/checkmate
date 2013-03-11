class HabitLinksController < ApplicationController
  def create
    habit_id = params[:habit_id]
    trigger = params[:trigger]
    HabitLink.where('user_id = ? AND habit_id = ? AND trigger = ?', current_user.id, habit_id, trigger)
      first_or_create

    case trigger
    when HabitLink::WITHINGS_SCALE
      User.delay.subscribe_withings(current_user.id)
    end

    flash[:notice] = 'Your subscription has been submitted'
    redirect_to root_path
  end

end
