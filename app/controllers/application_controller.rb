# encoding: utf-8
class ApplicationController < ActionController::Base
  helper_method :user_signed_in?, :current_user
  protect_from_forgery

  def login(user)
    session[:user_id] = user.id
    cookies[:user] = user.username
  end

  def logout
    session[:user_id] = nil
    cookies[:user] = nil
  end

  def authenticate_user!
    redirect_to new_session_path unless user_signed_in?
  end

  def current_user
    return unless session[:user_id]
    @current_user ||= User.first(:conditions => { :id => session[:user_id] })
  end

  def user_signed_in?
    current_user.present?
  end

  protected
    def update_user_password_with_nested_fields(type)
      unless params[type][:users_attributes].blank?
        for user in params[type][:users_attributes]
          if user[1][:password].blank?
            p user[1][:password]
            p '------------------------'
            user[1].delete(:password)
            user[1].delete(:password_confirmation)
          end
        end
      end
    end
end
