class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user

  def current_user
    return unless session[:user_id]
    @current_user ||= User.first(:conditions => { :id => session[:user_id] })
  end

  def user_signed_in?
    current_user.present?
  end

  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

end
