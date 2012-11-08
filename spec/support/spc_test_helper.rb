module SpecTestHelper
  def login(user)
    request.session[:user_id] = user.id
  end

  def logout
    request.session[:user_id] = nil
  end

  def current_user
    User.find(request.session[:user_id])
  end
end