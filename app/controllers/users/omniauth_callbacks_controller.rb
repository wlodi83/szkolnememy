# encoding: utf-8
require 'typhoeus'
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    auth = request.env["omniauth.auth"]
    @user = User.find_for_provider_oauth(auth, current_user, 'facebook')
    @user.skip_confirmation!
    logger.debug "The object is omniauth hash: #{auth}"

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      Typhoeus::Request.post(
      "https://graph.facebook.com/#{auth.uid}/feed",
      :body => {
        :access_token => auth.credentials.token,
        :message => Dialog.last.message,
        :link => Dialog.last.link,
        :caption => Dialog.last.caption,
        :description => Dialog.last.description,
        :picture => Dialog.last.picture.url(:medium),
        :name => Dialog.last.name
      })
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def twitter
    auth = request.env["omniauth.auth"]
    @user = User.find_for_provider_oauth(auth, current_user, 'twitter')
    @user.skip_confirmation!
    #TO DOskip email sending
    logger.debug "The object is omniauth hash: #{auth}"
    
    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      twitter_user = Twitter::Client.new(
        :oauth_token => auth.credentials["token"],
        :oauth_token_secret => auth.credentials["secret"]
      )
      Thread.new{twitter_user.update("Szkolne Memy. Najlepszy zbiór szkolnych memów. Odwiedź nas koniecznie: http://www.szkolnememy.pl/")}
      set_flash_message(:notice, :success, :kind => "Twitter") if is_navigational_format?
    else
      session["devise.twitter_uid"] = request.env["uid"]
      redirect_to new_user_registration_url
    end
  end

end
