class CreateHabitLinks < ActiveRecord::Migration
  def change
    create_table :habit_links do |t|
      t.integer :user_id
      t.integer :habit_id

      t.timestamps
    end
  end
end
