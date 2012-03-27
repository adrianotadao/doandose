class Company

  include Mongoid::Document
  include Mongoid::Timestamps

  field :active, :type => Boolean
  field :name, :type => String
  field :fancy_name, :type => String
  field :cnpj, :type => String
  field :responsible, :type => String

  #relationship
  has_one :address, :as => :addressable, dependent: :destroy
  has_one :contact, :as => :contactable, dependent: :destroy
  has_many :users, :as => :authenticatable, dependent: :destroy
  
  accepts_nested_attributes_for :address, :contact, :users, :allow_destoy => true

  #validations
  validates_presence_of :name, :fancy_name, :responsible, :address, :contact
  validates_uniqueness_of :name, :fancy_name

end