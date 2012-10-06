class Users::SessionsController < ApplicationController

    def current_user
      return unless session[:user_id]
      if @current_user.nil?
        @current_user = User.find(session[:user_id])
        logout if @current_user.nil?
      end
      @current_user
    end

    def user_signed_in?
      current_user.present?
    end

    def login(user)
      session[:user_id] = user.id
    end

    def logout
      session.destroy
      session[:user_id] = nil
      redirect_to root_path
    end

    def authenticate_user!
      redirect_to sign_in_path unless user_signed_in?
    end

    def admin_signed_in?
      session[:admin].present?
    end

    def admin_logout
      session.destroy
      session[:admin] = nil
      redirect_to root_path
    end
  end
end