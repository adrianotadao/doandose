class Users::IdentitiesController < ApplicationController
  #before_filter :authenticate_user!, :only => [:edit, :update]

  def new
    if user_signed_in?
      redirect_to edit_user_path
    else
      @user = User.new
      p 'identities new -------------------'
    end
  end

  def create
    p params
    p '-----------------------------------'
    reder 'new'
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update_attributes(params[:user])
      flash[:success] = 'Cadastro atualizado!'
      redirect_to Users.after_registration_path
    else
      render :action => 'edit'
    end
  end

end

