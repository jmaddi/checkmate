require 'spec_helper'

describe HabitLink do
  context 'no github push event today' do
    it '#update_github should not checkin' do

      user = create(:user)
      habit_link = create(:habit_link, user: user, habit_id: 1337, trigger: HabitLink::GITHUB_PUBLIC_COMMIT)

      client = double('client')
      Liftapp::Client.stub(:new).and_return(client)
      client.should_not_receive(:checkin)

      stub_request(:get, 'https://api.github.com/users/jmaddi/events').
        to_return(File.new(Rails.root.join('spec', 'fixtures', 'github_nopush').to_s))

      HabitLink.update_github
    end
  end

  context 'github push event today' do
    it '#update_github should checkin' do

      user = create(:user)
      habit_link = create(:habit_link, user: user, habit_id: 1337, trigger: HabitLink::GITHUB_PUBLIC_COMMIT)

      client = double('client')
      Liftapp::Client.stub(:new).and_return(client)
      client.should_receive(:checkin).with(1337)

      stub_request(:get, 'https://api.github.com/users/jmaddi/events').
        to_return(File.new(Rails.root.join('spec', 'fixtures', 'github_pushed').to_s))

      HabitLink.update_github
    end
  end

  context 'no runkeeper run event today' do
    it '#update_github should not checkin' do

      user = create(:user)
      token = create(:runkeeper_token, user: user)
      habit_link = create(:habit_link, user: user, habit_id: 1337, trigger: HabitLink::RUNKEEPER_RUN)

      client = double('client')
      Liftapp::Client.stub(:new).and_return(client)
      client.should_not_receive(:checkin)

      stub_request(:get, "https://api.runkeeper.com/user").
        to_return(File.new(Rails.root.join('spec', 'fixtures', 'runkeeper_user').to_s))

      stub_request(:get, "https://api.runkeeper.com/fitnessActivities").
        to_return(File.new(Rails.root.join('spec', 'fixtures', 'runkeeper_fitnessActivities_norun').to_s))


      HabitLink.update_runkeeper
    end
  end

  context 'runkeeper run event today' do
    it '#update_github should checkin' do

      user = create(:user)
      token = create(:runkeeper_token, user: user)
      habit_link = create(:habit_link, user: user, habit_id: 1337, trigger: HabitLink::RUNKEEPER_RUN)

      client = double('client')
      Liftapp::Client.stub(:new).and_return(client)
      client.should_receive(:checkin).with(1337)

      stub_request(:get, "https://api.runkeeper.com/user").
        to_return(File.new(Rails.root.join('spec', 'fixtures', 'runkeeper_user').to_s))

      stub_request(:get, "https://api.runkeeper.com/fitnessActivities").
        to_return(File.new(Rails.root.join('spec', 'fixtures', 'runkeeper_fitnessActivities_run').to_s))

      HabitLink.update_runkeeper
    end
  end


end
