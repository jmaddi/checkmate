require 'spec_helper'

describe HabitLink do
  it '#update_github should update linked habits' do
    habit_link = create(:habit_link)
    HabitLink.update_github
  end
end
