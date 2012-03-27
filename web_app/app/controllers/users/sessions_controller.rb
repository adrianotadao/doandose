class Users::SessionsController < ApplicationController  
  def new  
    if user_signed_in?
      redirect_to edit_user_path 
    else
      @user = User.new
    end
  end  
  
  def create  
    user = User.from_omniauth(env["omniauth.auth"])  
    session[:user_id] = user.id  
    redirect_to root_url, notice: "Signed in!"  
  end  
  
  def destroy  
    session[:user_id] = nil  
    redirect_to root_url, notice: "Signed out!"  
  end  
  
  def failure  
    redirect_to root_url, alert: "Authentication failed, please try again."  
  end  
end
