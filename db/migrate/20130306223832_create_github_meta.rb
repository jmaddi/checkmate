class CreateGithubMeta < ActiveRecord::Migration
  def change
    create_table :github_meta do |t|
      t.integer :consumer_token_id
      t.string :login
      t.integer :github_id

      t.timestamps
    end
  end
end
