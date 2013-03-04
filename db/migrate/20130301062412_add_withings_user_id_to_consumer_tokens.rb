class AddWithingsUserIdToConsumerTokens < ActiveRecord::Migration
  def change
    add_column :consumer_tokens, :withings_user_id, :integer
  end
end
