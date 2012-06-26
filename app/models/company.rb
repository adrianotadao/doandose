class Company

  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug

  field :active, :type => Boolean
  field :name, :type => String
  field :fancy_name, :type => String
  field :cnpj, :type => String
  field :responsible, :type => String
  
  slug :name

  #access control
  attr_accessible :name, :fancy_name, :cnpj, :responsible

  #relationship
  has_one :address, :as => :addressable, :dependent => :destroy, :autosave => true
  has_one :contact, :as => :contactable, :dependent => :destroy, :autosave => true
  has_one :user, :as => :authenticable, :dependent => :destroy, :autosave => true
  
  accepts_nested_attributes_for :address, :contact, :user, :allow_destoy => true

  #validations
  validates_presence_of :name, :fancy_name, :responsible, :address, :contact, :user
  validates_uniqueness_of :name, :fancy_name, :cnpj

end