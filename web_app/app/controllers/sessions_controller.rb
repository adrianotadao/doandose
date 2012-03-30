class SessionsController < ApplicationController  
  def new  
  end  
  
  def create  
    auth = request.env["omniauth.auth"] 
    p auth
    p '================' 
    user = User.find params[:id] 
    p user
    if user
      render :text => "Bem vindo #{@authorization.user.name}! Voce esta logado."
    else
      User.create_with_omniauth(auth) 
    end 
    session[:user_id] = user.id  
    redirect_to root_url, :notice => "Signed in!"  
  end 
  
  def destroy  
    session[:user_id] = nil  
    redirect_to root_url, :notice => "Signed out!"  
  end 
  
  def failure  
    redirect_to root_url, alert: "Autenticacao falhada tente novamente!"  
  end
end
