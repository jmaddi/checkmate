class GithubToken < Oauth2Token
  after_create :populate_meta

  def self.consumer
    @consumer||=create_consumer
  end

  def self.create_consumer(options={})
    @consumer||=OAuth2::Client.new credentials[:key],credentials[:secret],credentials[:options]
    @consumer.options.merge!(credentials[:options])
    @consumer
  end

  def self.authorize_url(callback_url)
    options = {:redirect_uri=>callback_url}
    options[:scope] = credentials[:scope] if credentials[:scope].present?
    consumer.auth_code.authorize_url(options)
  end

  def self.access_token(user, code, redirect_uri)
    access_token = consumer.auth_code.get_token(code, :redirect_uri => redirect_uri)
    find_or_create_from_access_token user, access_token
  end

  def client
    @client ||= OAuth2::AccessToken.new self.class.consumer, token
  end

  def populate_meta
    meta_data = GithubMeta.find_or_initialize_by_consumer_token_id(id)
    client = Octokit::Client.new(oauth_token: token)
    user = client.user
    meta_data.login = user.login
    meta_data.save!
  end

  has_one :meta, class_name: 'GithubMeta', foreign_key: :consumer_token_id, inverse_of: :github_token

end
