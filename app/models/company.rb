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

  #relationship
  has_one :address, :as => :addressable, dependent: :destroy, autosave: true
  has_one :contact, :as => :contactable, dependent: :destroy, autosave: true
  has_many :users, :as => :authenticable, dependent: :destroy, autosave: true
  
  accepts_nested_attributes_for :address, :contact, :users, :allow_destoy => true

  #validations
  validates_presence_of :name, :fancy_name, :responsible, :address, :contact, :users
  validates_uniqueness_of :name, :fancy_name, :cnpj

end