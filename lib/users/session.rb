module Users
  module Session
    def current_user
      return unless session[:user_id]
      if @current_user.nil?
        @current_user = User.find(session[:user_id])
        logout if @current_user.nil?
      end
      @current_user
    end

    def current_institution
      return unless session[:institution_user_id]
      if @current_institution.nil?
        @current_institution = User.find(session[:institution_user_id])
        logout_company if @current_institution.nil?
      end
      @current_institution
    end

    def user_signed_in?
      current_user.present?
    end

    def company_signed_in?
      current_institution.present?
    end

    def login(user)
      institution?(user)
      cookies[:email] = { value: user.email, :expires => 10.years.from_now }
      cookies[:lat] = { value: user.authenticable.address.loc[0], :expires => 10.years.from_now }
      cookies[:lng] = { value: user.authenticable.address.loc[1], :expires => 10.years.from_now }
    end

    def institution?(user)
      user.authenticable_type == 'Company' ? session[:institution_user_id] = user.id : session[:user_id] = user.id
    end

    def logout
      session.destroy
      session[:user_id] = nil

      cookies.delete :email
      cookies.delete :lat
      cookies.delete :lng

      redirect_to root_path
    end

    def logout_company
      session.destroy
      session[:institution_user_id] = nil
      redirect_to root_path
    end

    def authenticate_user!
      redirect_to users_new_session_path unless user_signed_in?
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