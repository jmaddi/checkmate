require 'spec_helper'

describe LiftController do
  before(:each) do
    @user = User.new
    @user.email = 'test@test.com'
    @user.save!
  end

  describe "GET 'login'" do
    it "returns http success" do
      client = double('client', email: 'test@test.com')
      Liftapp::Client.stub(:new).with('test@test.com', 'swordfish').and_return(client)

      post 'login', email: 'test@test.com', password: 'swordfish'

      flash[:notice].should eq('You have been logged in successfully.')
      expect(response).to redirect_to(root_path)
    end
  end

end
