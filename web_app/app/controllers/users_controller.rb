class UsersController < ApplicationController
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
