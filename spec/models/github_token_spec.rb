require 'spec_helper'

describe GithubToken do
  it '#populate_meta should create githubtoken' do
    user = User.create!(email: 'test@test.com')
    token = GithubToken.find_or_initialize_by_user_id_and_token(user.id, 'b9890deadbeef59316ceeba2d2bba142c5faf9cf')

    stub_request(:get, 'https://api.github.com/user').to_return(File.new(Rails.root.join('spec', 'fixtures', 'user').to_s))

    token.save!
    token.meta.login.should == 'jmaddi'
  end
end
