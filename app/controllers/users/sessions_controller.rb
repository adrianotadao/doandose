class Users::SessionsController < ApplicationController  
  before_filter :check_user_existence, :only => :create

  def new
  end

  def create
    @authentication = Authentication.first(:conditions => { :provider => auth_hash.provider, :uid => auth_hash.uid })

    case
      when @authentication then sign_in
      when @user then add_new_authentication_non_logged
      when current_user then add_new_authentication_logged
      else sign_up 
    end
  end

  def failure
    render '/users/sessions/new', :status => 401
  end
  
  def destroy  
    session[:user_id] = nil  
    redirect_to root_url, :notice => "Signed out!"  
  end 
  
  private
    def check_user_existence
      case
        when auth_hash['info']['nickname'].present? then @user = User.first(:conditions => { :username => auth_hash['info']['nickname'] })
        when auth_hash['info']['email'].present? then @user = User.first(:conditions => { :email => auth_hash['info']['email'] })
      end
    end

    def add_new_authentication_non_logged
      @user.add_authentication(auth_hash)
      login @user
      redirect_to Users.after_login_path
    end
    
    def add_new_authentication_logged
      current_user.add_authentication(auth_hash)
      redirect_to edit_user_path
    end
  
    def auth_hash
      request.env['omniauth.auth']
    end

    def sign_in
      login @authentication.user
      redirect_to Users.after_login_path, :status => 200
    end
    
    def sign_up
      @person = Person.new
      @person.user = User.new_with_omniauth(auth_hash)
      render '/people/new'
    end
end