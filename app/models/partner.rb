class Partner
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug

  field :active, type: Boolean, default: false
  field :name, type: String
  field :site, type: String

  slug :name

  #access control
  attr_accessible :name, :site, :active, :logo_attributes

  #relationship
  has_one :logo, class_name: 'PartnerLogo', as: :assetable, dependent: :destroy, autosave: true
  accepts_nested_attributes_for :logo

  #validations
  validates_presence_of :name, :logo
  validates_format_of :site, with: URI::regexp, if: :site?
end