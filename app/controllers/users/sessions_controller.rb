class Users::SessionsController < ApplicationController  
  def new
  end

  def create
    
    case
    when request.env['omniauth.auth']['info']['nickname'].present? then @user = User.first(:conditions => { :username => request.env['omniauth.auth']['info']['nickname'] })
    when request.env['omniauth.auth']['info']['email'].present? then @user = User.first(:conditions => { :email => request.env['omniauth.auth']['info']['email'] })
    end
    
    @authentication = Authentication.first(:conditions => { :provider => auth_hash.provider, :uid => auth_hash.uid })

    case
    when @authentication then sign_in
    when @user then add_new_authentication2
    when current_user then add_new_authentication
    else sign_up end
  end

  def failure
    #p '-------------------failure'
    #p request.env["HTTP_REFERER"]
    
    render '/users/sessions/new', :status => 401
  end
  
  def destroy  
    session[:user_id] = nil  
    redirect_to root_url, :notice => "Signed out!"  
  end 
  
  private
    def auth_hash
      request.env['omniauth.auth']
    end

    def sign_in
      login @authentication.user
      redirect_to Users.after_login_path, :status => 200
    end
    
    def sign_up
      @user = User.new_with_omniauth(auth_hash)
      render '/users/identities/new'
    end
end
