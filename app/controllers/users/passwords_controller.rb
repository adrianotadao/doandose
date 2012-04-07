#encoding: utf-8
class Users::PasswordsController < ApplicationController
  def new
  end
  
  def create
    @user = User.first(conditions: {email: params[:email]})
    @errors = []

    if @user && @user.has_identity?
      @user.prepare_to_reset_password!
      PasswordMailer.send_reset_password_instructions(@user.id).deliver
      redirect_to Users.after_login_path, :status => 200
    else
      @errors << 'Email inválido'        
      render :action => 'new'
    end
  end
  
  def edit
    @user = User.first(conditions: {reset_password_token: params[:token] })
  end
  
  def update
    @user = User.first(conditions: {reset_password_token: params[:token] })
          
    if @user && @user.update_attributes(:password => params[:user][:password], :password_confirmation => params[:user][:password_confirmation])        
      @user.password_is_reseted!
      login @user
      redirect_to Users.after_login_path, :status => 200
    else
      render :action => 'edit', :params => {:token => params[:token]}
    end
  end
end

