# encoding: utf-8
class ApplicationController < ActionController::Base
  include Users::Session
  helper_method :user_signed_in?, :current_user, :admin_signed_in?, :logout

  before_filter :check_root_path

  def check_root_path
    if current_user && request.path == '/'
      redirect_to(institution_root_path) if current_user.authenticable_type == 'Company'
    end
  end

  def destroy
    logout
    redirect_to root_path
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
    return if Rails.env == 'development'
    authenticate_or_request_with_http_basic do |user, password|
      user == 'admin' && (password == '1d9c67ca9c863538ced48518789b1ef' || password == 'teste')
      session[:admin] = { :value => true}
    end
  end
end