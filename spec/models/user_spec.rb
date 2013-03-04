require 'spec_helper'

describe User do
  before(:each) do
    @user = User.new
    @user.email = 'test@test.com'
    @user.id=4
    @user.save!

    @withingsToken = WithingsToken.new
    @withingsToken.token = '123'
    @withingsToken.secret = '345'
    @user.withings = @withingsToken

    @withings_user = Withings::User.new(id: '3', oauth_token: '123', oauth_token_secret: '345')
  end
  it '#subscribe_withings should authenticate @user' do
    Withings::User.should_receive(:authenticate).with('4', '123', '345').and_return(@withings_user)
    Withings::User.any_instance.stub(:list_notifications).with(Withings::SCALE).and_return([])
    Withings::User.any_instance.stub(:subscribe_notification)
    @user.subscribe_withings
  end
  it '#subscribe_withings should check notifications' do
    Withings::User.stub(:authenticate).and_return(@withings_user)
    Withings::User.any_instance.should_receive(:list_notifications).with(Withings::SCALE).and_return([])
    Withings::User.any_instance.stub(:subscribe_notification)
    @user.subscribe_withings
  end
  it '#subscribe_withings should create new notification' do
    Withings::User.stub(:authenticate).and_return(@withings_user)
    Withings::User.any_instance.stub(:list_notifications).with(Withings::SCALE).and_return([])
    @withings_user.should_receive(:subscribe_notification).with('http://google.com', anything(), Withings::SCALE)
    @user.subscribe_withings
  end

  context 'notification already exists' do
    before(:each) do
      Withings::User.any_instance.stub(:list_notifications).and_return([
        Withings::NotificationDescription.new(callbackurl: 'http://google.com', comment: 'mycomment', expires: 123)
      ])
    end

    it '#subscribe_withings should not create new notification' do
      Withings::User.stub(:authenticate).and_return(@withings_user)
      @withings_user.should_not_receive(:subscribe_notification)
      @user.subscribe_withings
    end
  end
end
