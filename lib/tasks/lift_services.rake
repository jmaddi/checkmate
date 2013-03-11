namespace :lift_services do
  task :update_github => :environment do
    puts 'Updating GitHub'
    HabitLink.update_github
  end

  task :update_runkeeper => :environment do
    puts 'Updating Runkeeper'
    HabitLink.update_runkeeper
  end
end
