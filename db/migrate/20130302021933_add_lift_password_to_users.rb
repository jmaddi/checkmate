class AddLiftPasswordToUsers < ActiveRecord::Migration
  def change
    add_column :users, :lift_password, :string
  end
end
