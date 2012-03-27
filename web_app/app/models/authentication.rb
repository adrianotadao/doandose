class Authentication
  include Mongoid::Document
  include Mongoid::Timestamps

  #attributes
  field :provider
  field :uid

  index :provider
  index :uid
  index [:provider, :uid]

  #relationship
  belongs_to :user

  #validations
  validates_presence_of :uid, :provider, :user
  validates_uniqueness_of :provider, :scope => :user
  validates_uniqueness_of :uid, :scope => :user


  def self.from_omniauth(auth)  
    find_by_provider_and_uid(auth["provider"], auth["uid"]) || create_with_omniauth(auth)  
  end  
  
  def self.create_with_omniauth(auth)  
    create! do |user|  
      user.provider = auth["provider"]  
      user.uid = auth["uid"]  
      user.name = auth["info"]["name"]  
    end  
  end

end
