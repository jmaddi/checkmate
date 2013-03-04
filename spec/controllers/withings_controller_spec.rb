require 'spec_helper'

describe WithingsController do
  before(:each) do
    @user = User.new
    @user.id=99
    @user.email = 'test@test.com'
    @user.save!

    @withingsConsumer = WithingsToken.new
    @withingsConsumer.withings_user_id = 314
    @withingsConsumer.user = @user
    @withingsConsumer.token = '123'
    @withingsConsumer.save!
  end

  it '#notify looks up @user' do
    joined = double('joined', where: @user)
    User.should_receive(:joins).and_return(joined)
    joined.should_receive(:where).and_return([@user])

    withings_user = double('withings_user', measurement_groups: [])
    Withings::User.stub(:authenticate).and_return(withings_user)

    client = double('client', checkin: 12)
    Liftapp::Client.should_receive(:new).and_return(client)

    post :notify, userid: 314
  end

  it '#notify looks up linked habits' do
    User.any_instance.should_receive(:habit_links).and_return([])
    
    withings_user = double('withings_user', measurement_groups: [])
    Withings::User.stub(:authenticate).and_return(withings_user)

    client = double('client', checkin: 12)
    Liftapp::Client.should_receive(:new).and_return(client)

    post :notify, userid: 314
  end

  it '#notify retrieves weight' do
    withings_user = double('withings_user')
    withings_user.should_receive(:measurement_groups)
    Withings::User.should_receive(:authenticate).and_return(withings_user)

    client = double('client', checkin: 12)
    Liftapp::Client.should_receive(:new).and_return(client)

    post :notify, userid: 314
  end

  it '#notify checks into habits' do
    User.any_instance.stub(:habit_links).and_return([HabitLink.new(user_id: @user.id, habit_id: 12)])
    withings_user = double('withings_user', measurement_groups: [])
    Withings::User.stub(:authenticate).and_return(withings_user)

    client = double('client')

    client.should_receive(:checkin).with(12)
    Liftapp::Client.should_receive(:new).and_return(client)

    post :notify, userid: 314
  end
end
