class LiftController < ApplicationController
  def login
    #begin
    client = Liftapp::Client.new(params[:email], params[:password])
    user = User.where(email: client.email).first_or_create(lift_password: params[:password], full_name: client.name, picture_url: client.picture_url)
    sign_in :user, user
    flash[:notice] = 'You have been logged in successfully.'
    #rescue Liftapp::AccessDenied
    #  flash[:error] = 'Invalid email/password'
    #rescue
    #  flash[:error] = 'Error logging in, please try again'
    #end
    redirect_to root_path
  end
  def habits
    client = Liftapp::Client.new(current_user.email, current_user.lift_password)
    data = client.dashboard
    habits = data['subscriptions'].map do |h|
      {id: h['habit']['id'], name: h['habit']['name']}
    end
    render json: habits.to_json
  end
end
