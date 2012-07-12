class Users::SessionsController < ApplicationController  
  def new
  end

  def create
    @authentication = Authentication.first(:conditions => { :provider => auth_hash.provider, :uid => auth_hash.uid })
    case
      when @authentication then sign_in
      when current_user then add_new_authentication
      else sign_up
    end
  end

  def failure
    render '/users/sessions/new', :status => 401
  end
  
  def destroy  
    session[:user_id] = nil
    logout
    redirect_to root_url, :notice => "Signed out!"  
  end 
  
  private
    def auth_hash
      request.env['omniauth.auth']
    end

    def sign_in
      login @authentication.user
      
      unless @authentication.provider.eql?('identity')
        render 'callback_sign'
      else
        render 'callback_sign_popup'
      end
    end
    
    def sign_up
      session[:person_params] ||= {}
      @person = Person.new(session[:person_params])
      @person.current_step = session[:person_step]
      #@person.user = User.new_with_omniauth(auth_hash)
      @user = User.parse_omniauth(auth_hash)
      unless auth_hash.provider.eql?('identity')
        render 'callback_signup_popup'
      else
        render 'callback_change_step'
      end
    end
      
    def add_new_authentication
      current_user.add_authentication(auth_hash)
      redirect_to edit_user_path
    end
    
end
