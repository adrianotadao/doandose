class Partner
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug
  
  field :active, :type => Boolean
  field :name, :type => String
  field :site, :type => String
  slug :name
  
  #relationship
  has_one :logo, :class_name => "PartnerLogo", :as => :assetable, dependent: :destroy, autosave: true
  
  #validations
  validates_presence_of :name, :logo
  validates_format_of :site, :with => URI::regexp, :if => :site?
  
  accepts_nested_attributes_for :logo
end