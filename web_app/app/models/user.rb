class User
  include Mongoid::Document
  include Mongoid::Timestamps

  #attributes
  field :provider
  field :uid
  field :name

  def self.create_with_omniauth(auth)  
    create! do |user|  
      user.provider = auth["provider"]  
      user.uid = auth["uid"]  
      user.name = auth["user_info"]["name"]  
    end  
  end  
end
