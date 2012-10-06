# encoding: utf-8
class Users::SessionsController < ApplicationController
  def new
  end

  def create
    p 'aqui ============'
    @authentication = Authentication.where(:provider => auth_hash.provider, :uid => auth_hash.uid).first

    case
      when @authentication then sign_in
      when current_user then add_new_authentication
      else sign_up
    end
  end

  def failure
    if current_user
      render "/sessions/callback_failure_popup_edit"
    else
      @user = User.new
      @user.authentications.build(:provider => 'foo')
      if params[:strategy] == 'identity'
        render '/identities/new'
      else
        render '/sessions/callback_failure_popup_new'
      end
    end
  end

  def destroy
    logout
    render nothing: true
  end

  private
    def auth_hash
      request.env['omniauth.auth']
    end

    def sign_in
      login @authentication.user
      if @authentication.provider.eql?('identity')
        render 'callback_input'
      else
        render 'callback_popup'
      end
    end

    def sign_up
      @user = Users::User.parse_omniauth(auth_hash)
      render 'callback_signup'
    end

    def add_new_authentication
      current_user.add_authentication(auth_hash)
      @user = {
         :state => :edit,
          :authentication => {
            :provider => auth_hash.provider,
            :uid => auth_hash.uid
          }
      }
      @authentications = User.social_networks(current_user)
      render '/sessions/callback_close_popup_edit'
    end
end