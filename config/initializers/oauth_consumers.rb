OAUTH_CREDENTIALS = {
  withings: {
    key: ENV['WITHINGS_OAUTH_KEY'],
    secret: ENV['WITHINGS_OAUTH_SECRET']
  },
  github: {
    key: ENV['GITHUB_OAUTH_CLIENT_ID'],
    secret: ENV['GITHUB_OAUTH_SECRET'],
    options: {
      site: 'https://github.com',
      authorize_url: '/login/oauth/authorize',
      token_url: '/login/oauth/access_token'
    }
  }
}
