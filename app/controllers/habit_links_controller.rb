class HabitLinksController < ApplicationController
  def create
    HabitLink.find_or_create_by_user_id_and_habit_id(current_user.id, params[:habit_id])
    User.delay.subscribe_withings(current_user.id)
    flash[:notice] = 'Your subscription has been submitted'
    redirect_to root_path
  end

end
