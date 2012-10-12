class Partner
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slugify

  field :active, type: Boolean, default: false
  field :name, type: String
  field :site, type: String

  #access control
  attr_accessible :name, :site, :active, :logo_attributes

  #relationship
  has_one :logo, class_name: 'PartnerLogo', as: :assetable, dependent: :destroy, autosave: true
  accepts_nested_attributes_for :logo

  #validations
  validates_presence_of :name
  validates_format_of :site, with: URI::regexp, if: :site?

  private
  def generate_slug
    name.parameterize
  end
end