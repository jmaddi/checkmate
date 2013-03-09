# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :github_metum, :class => 'GithubMeta' do
    consumer_token_id 1
    login "MyString"
    github_id 1
  end
end
