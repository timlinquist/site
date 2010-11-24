class TryController < ApplicationController
  # require the gem twitter_oauth
  require 'twitter_oauth'
  # need user logged in
  before_filter :login_required

  # initialize your twitter key and secret ( you can get from here
  # http://apiwiki.twitter.com/ )
  TWITTER_KEY = 'ngFg1EFs1htBwojgCYqcgg'
  TWIITER_SECRET = 'cV0mzL2swcNhEFAhkSSuhTdqEJzYrC4tYJneIf0LTE'

  # The url to back when user has authorize your app
  TWITTER_CALLBACK_URL = 'http://localhost:3000/try/callback'

  #index method
  # this method check if user has authorize your app
  # if no it'll show they link to authorize your app in their twitter account
  def index
    if !current_user.has_twitter_oauth?
      @T_OAUTH = TwitterOAuth::Client.new( :consumer_key => TWITTER_KEY, :consumer_secret => TWIITER_SECRET )
      @T_REQUEST_TOKEN = @T_OAUTH.request_token  auth_callback => TWITTER_CALLBACK_URL
      @T_TOKEN = @T_REQUEST_TOKEN.token
      @T_SECRET = @T_REQUEST_TOKEN.secret
      @link = @T_REQUEST_TOKEN.authorize_url
      session['token' ] = @T_TOKEN
      session['secret'] = @T_SECRET
    end
  end

  # Method callback
  # this method will call after user authorize your app in twitter website
  # this method will authorize oauth token and verifier send from twitter and if success key and secret will stored in database
  def callback
    @T_OAUTH = TwitterOAuth::Client.new(:consumer_key => TWITTER_KEY, :consumer_secret => TWIITER_SECRET )
    @oauth_verifier = params[:oauth_verifier]
    access_token = @T_OAUTH.authorize(session['token'], session['secret'],  auth_verifier => @oauth_verifier)
    if (@result = @T_OAUTH.authorized?)
      current_user.create_or_update_twitter_account_with_oauth_token(access_token.token, access_token.secret)
      session['token'] = nil
      session['secret'] = nil
      flash[:notice] = "Authorize complete"
    else
      flash[:notice] = "Authorize failed"
    end

  rescue
    flash[:notice] = "Authorize failed"
  end

  # method update status
  # this method is for sent tweet to your twitter
  def update_status
    if current_user.has_twitter_oauth?
      @T_OAUTH = TwitterOAuth::Client.new(
                         :consumer_key => TWITTER_KEY,
                         :consumer_secret => TWIITER_SECRET,
                         :token => current_user.twitter_account.token,
                         :secret => current_user.twitter_account.secret 
                                          )

      if @T_OAUTH.authorized? and @T_OAUTH.update(params[:status])
        flash[:notice] = "Your tweet has been sent"
      else
        flash[:notice] = "Sorry ! Your tweet failed to sent, try later !"
      end
    else
      flash[:notice] = "You dont have twitter account with oauth token, please authorize myapp in your twitter !"
    end

    redirect_to :action => 'index'

  end
end
