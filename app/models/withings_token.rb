class WithingsToken < ConsumerToken
  WITHINGS_SETTINGS = {
    site: 'http://wbsapi.withings.net/',
    #scheme: 'query_string',
    request_token_url: 'https://oauth.withings.com/account/request_token',
    authorize_url: 'https://oauth.withings.com/account/authorize',
    access_token_url: 'https://oauth.withings.com/account/access_token'
  }

  def self.consumer
    @consumer ||= create_consumer
  end

  def self.create_consumer(options={})
    OAuth::Consumer.new credentials[:key], credentials[:secret], WITHINGS_SETTINGS.merge(options)
  end

  def self.find_or_create_from_request_token(user,withings_user_id, token,secret,oauth_verifier)
    request_token=OAuth::RequestToken.new consumer,token,secret
    options={}
    options[:oauth_verifier]=oauth_verifier if oauth_verifier
    access_token=request_token.get_access_token options
    find_or_create_from_access_token user, withings_user_id, access_token
  end

  def self.find_or_create_from_access_token(user,withings_user_id, access_token)
    secret = access_token.respond_to?(:secret) ? access_token.secret : nil
    if user
      token = self.find_or_initialize_by_user_id_and_withings_user_id_and_token(user.id, withings_user_id, access_token.token)
    else
      token = self.find_or_initialize_by_token(access_token.token)
    end

    # set or update the secret
    token.secret = secret
    token.save! if token.new_record? or token.changed?

    token
  end

end
