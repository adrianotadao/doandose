class Company
  # Includes
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slugify

  # Fields
  field :name, type: String
  field :fancy_name, type: String
  field :cnpj, type: String
  field :responsible, type: String

  # Access control
  attr_accessible :name, :fancy_name, :cnpj, :responsible, :address_attributes,
    :contact_attributes, :user_attributes

  # Relationships
  has_one :address, as: :addressable, dependent: :destroy, autosave: true
  has_one :contact, as: :contactable, dependent: :destroy, autosave: true
  has_one :user, as: :authenticable, dependent: :destroy, autosave: true
  has_many :notifications, dependent: :destroy
  has_many :campaigns, dependent: :destroy

  accepts_nested_attributes_for :address, :contact, :user, allow_destoy: true

  # Validations
  validates_presence_of :name, :fancy_name, :responsible, :address, :contact,
    :user, :cnpj
  validates_uniqueness_of :name, :fancy_name, :cnpj

  # Others
  private
  def generate_slug
    name.parameterize
  end
end