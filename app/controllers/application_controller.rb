# encoding: utf-8
class ApplicationController < ActionController::Base
  helper_method :user_signed_in?, :current_user, :admin_signed_in?
  protect_from_forgery

  def login(user)
    session[:user_id] = user.id
  end

  def logout
    reset_session
    session[:user_id] = nil
    cookies[:user] = nil
    cookies[:admin] = nil
    redirect_to root_path
  end

  def authenticate_user!
    redirect_to new_session_path unless user_signed_in?
  end

  def current_user
    return unless session[:user_id]
    @current_user ||= User.first(conditions: { id: session[:user_id] })
  end

  def user_signed_in?
    current_user.present?
  end

  def admin_signed_in?
    cookies[:admin].present?
  end

  protected
    def update_user_password_with_nested_fields(type)
      unless params[type][:users_attributes].blank?
        for user in params[type][:users_attributes]
          if user[1][:password].blank?
            user[1].delete(:password)
            user[1].delete(:password_confirmation)
          end
        end
      end
    end

  def authenticate_admin
    return unless Rails.env == 'development'
    authenticate_or_request_with_http_basic do |user, password|
      user == 'admin' && (password == '1d9c67ca9c863538ced48518789b1ef' || password == 'teste')
      cookies.permanent[:admin] = true
    end
  end
end