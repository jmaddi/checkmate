class AddTriggerToHabitLinks < ActiveRecord::Migration
  def change
    add_column :habit_links, :trigger, :integer
  end
end
