class Users::IdentitiesController < ApplicationController
  #before_filter :authenticate_user!, :only => [:edit, :update]
  
  def new
    if user_signed_in?
      redirect_to edit_user_path 
    else
      @user = User.new
      redirect_to new_person_path 
    end
  end

  def create
    case
    when params[:user][:email].present? then @user = User.first(:conditions => {:email => params[:user][:email]})
    when params[:user][:username].present? then @user = User.first(:conditions => {:username => params[:user][:username]})
    end
     
    if @user
      #@user.add_authentication2
    else

      @user = User.new(params[:user])
      @user.favorites = eval(cookies[:favorites]) unless cookies[:favorites].blank?

      #if verify_recaptcha
      if @user.save
        login @user
        redirect_to Users.after_registration_path
      else
        render '/users/identities/new'
      end
      #else
      #  @user.errors[:base] << 'Verifique o captcha'
      #  render '/users/identities/new'
      #end
    end

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

