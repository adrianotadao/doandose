module Users
  # Paths
  mattr_accessor :after_login_path
  @@after_login_path = '/'
  
  mattr_accessor :after_logout_path
  @@after_logout_path = '/'
  
  mattr_accessor :after_registration_path
  @@after_registration_path = '/'
end
