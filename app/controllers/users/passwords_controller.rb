#encoding: utf-8
class Users::PasswordsController < ApplicationController
  def new
  end

  def create
    @user = User.where(email: params[:email]).first
    if @user
      @user.prepare_to_reset_password!
      Mailer.reset_password_instructions(@user.id).deliver
      redirect_to users_new_session_path
    else
      render action: 'new'
    end
  end

  def edit
    if reset_password_token?
      logout
      @user = User.first(conditions: {reset_password_token: params[:token] })
    else
      redirect_to users_new_session_path, notice: t('flash.reset_password.reset_no_exists')
    end
  end

  def update
    @user = User.first(conditions: {reset_password_token: params[:token] })
    if @user && new_password_valid? && @user.update_attributes(password: params[:user][:password], password_confirmation: params[:user][:password_confirmation])
      @user.password_is_reseted!
      login @user
      redirect_to root_path
    else
      render action: 'edit', params: {token: params[:token]}
    end
  end

  private
    def reset_password_token?
      User.where(reset_password_token: params[:token]).exists?
    end

    def new_password_valid?
      !params[:user][:password].blank? && !params[:user][:password_confirmation].blank? &&
      params[:user][:password] == params[:user][:password_confirmation]
    end
end

