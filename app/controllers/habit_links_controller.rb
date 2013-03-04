class HabitLinksController < ApplicationController
  def create
    HabitLink.find_or_create_by_user_id_and_habit_id(current_user.id, params[:habit_id])
    current_user.subscribe_withings
    flash[:notice] = 'Subscription has been created'
    redirect_to root_path
  end

end
