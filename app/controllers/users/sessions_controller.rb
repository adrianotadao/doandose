# encoding: utf-8
class Users::SessionsController < ApplicationController
  def new
    redirect_to root_path if current_user
  end

  def create
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
        redirect_to users_new_session_path
      else
        render 'users/sessions/callback_failure'
      end
    end
  end

  def destroy
    logout
  end

  private
    def auth_hash
      request.env['omniauth.auth']
    end

    def sign_in
      if @authentication.user.authenticable_type == 'Company'
        login @authentication.user
        redirect_to institution_root_path
      else
        redirect_to_user
      end
    end

    def redirect_to_user
      if @authentication.provider.eql?('identity')
        login @authentication.user
        redirect_to root_path
      else
        login @authentication.user
        render 'users/sessions/callback_popup'
      end
    end

    def sign_up
      @user = User.parse_omniauth(auth_hash)
      render 'users/sessions/callback_subscribe'
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
      render 'users/sessions/callback_close_popup_edit'
    end
end