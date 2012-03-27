class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_user
    return unless session[:user_id]
    @current_user ||= User.first(:conditions => { :id => session[:user_id] })
  end

  def user_signed_in?
    current_user.present?
  end
end
