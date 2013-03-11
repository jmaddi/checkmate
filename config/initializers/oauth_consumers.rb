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
  },
  runkeeper: {
    key: ENV['RUNKEEPER_OAUTH_CLIENT_ID'],
    secret: ENV['RUNKEEPER_OAUTH_SECRET'],
    options: {
      site: 'https://runkeeper.com',
      authorize_url: '/apps/authorize',
      token_url: '/apps/token'
    }
  }
}
