class GithubMeta < ActiveRecord::Base
  attr_accessible :consumer_token_id, :github_id, :login

  belongs_to :github_token, foreign_key: :consumer_token_id, inverse_of: :meta
end
