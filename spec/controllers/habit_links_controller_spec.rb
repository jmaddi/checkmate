require 'spec_helper'

describe HabitLinksController do
  describe 'POST #create' do
    before (:each) do
      @user = User.new
      @user.id=42
      @user.email= 'test@test.com'
      @user.save!
      sign_in @user
    end

    it 'creates withings notification' do
      User.any_instance.should_receive(:subscribe_withings)
      post :create, habit_id: 3
    end
    it 'adds link to database' do
      User.any_instance.stub(:subscribe_withings)
      post :create, habit_id: 3
      HabitLink.where(habit_id: 3, user_id: 42).should_not be_nil
    end
    it 'should update flash message' do
      User.any_instance.stub(:subscribe_withings)
      post :create, habit_id: 3
      flash[:notice].should eq('Subscription has been created')
      expect(response).to redirect_to(root_path)
    end
  end
end
