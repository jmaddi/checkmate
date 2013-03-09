require 'spec_helper'

describe HabitLink do
  it '#update_github should update linked habits' do

    user = create(:user)
    habit_link = create(:habit_link, user: user, habit_id: 1337)

    client = double('client')
    Liftapp::Client.stub(:new).and_return(client)
    client.should_receive(:checkin).with(1337)

    HabitLink.update_github
  end
end
