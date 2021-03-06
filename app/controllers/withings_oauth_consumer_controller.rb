require 'oauth/controllers/consumer_controller'
class WithingsOauthConsumerController < ApplicationController
  include Oauth::Controllers::ConsumerController

  # To fix error "uninitialized constant Oauth::Controllers::ConsumerController::Oauth2Token"
  #class Oauth::Controllers::ConsumerController::Oauth2Token; end

  before_filter :authenticate_user!, :only=>:index

  def index
    @consumer_tokens=ConsumerToken.all :conditions=>{:user_id=>current_user.id}
    @services=OAUTH_CREDENTIALS.keys-@consumer_tokens.collect{|c| c.class.service_name}
  end

  def callback
    logger.info "CALLBACK"
    @request_token_secret=session[params[:oauth_token]]
    if @request_token_secret
      @token=@consumer.find_or_create_from_request_token(current_user,params[:userid], params[:oauth_token],@request_token_secret,params[:oauth_verifier])
      session[params[:oauth_token]] = nil
      if @token
        # Log user in
        if logged_in?
          flash[:notice] = "#{params[:id].humanize} was successfully connected to your account"
        else
          self.current_user = @token.user
          flash[:notice] = "You logged in with #{params[:id].humanize}"
        end
        go_back
      else
        flash[:error] = "An error happened, please try connecting again"
        redirect_to oauth_consumer_url(params[:id])
      end
    end
  end

  def client
    super
  end


  protected

  # Change this to decide where you want to redirect user to after callback is finished.
  # params[:id] holds the service name so you could use this to redirect to various parts
  # of your application depending on what service you're connecting to.
  def go_back
    redirect_to root_url
  end

  # The plugin requires logged_in? to return true or false if the user is logged in. Uncomment and
  # call your auth frameworks equivalent below if different. eg. for devise:
  #
  def logged_in?
    user_signed_in?
  end

  # The plugin requires current_user to return the current logged in user. Uncomment and
  # call your auth frameworks equivalent below if different.
  #def current_user
  #  current_user
  #end

  # The plugin requires a way to log a user in. Call your auth frameworks equivalent below
  # if different. eg. for devise:
  #
  def current_user=(user)
    sign_in(user)
  end

  # Override this to deny the user or redirect to a login screen depending on your framework and app
  # if different. eg. for devise:
  #
  #def deny_access!
  #  raise Acl9::AccessDenied
  #end
end
