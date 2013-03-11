HealthGraph.configure do |config|
  config.client_id     = ENV['RUNKEEPER_OAUTH_CLIENT_ID']
  config.client_secret = ENV['RUNKEEPER_OAUTH_SECRET']
end
