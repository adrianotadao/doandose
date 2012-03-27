class UsersController < ApplicationController

  def new
    if user_signed_in?
      redirect_to edit_user_path 
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(params[:user])
    
    if @user.save
      redirect_to users_path
    else
      render :action => 'user'
    end
  end

  def index
    @users = User.all
  end 
end
