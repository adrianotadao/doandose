class Campaign
  # Includes
  include Mongoid::Document
  include Mongoid::Slugify

  # Fields
  field :active, type: Boolean, default: true
  field :title, type: String
  field :content, type: String
  field :quantity, type: Integer
  field :expired_at, type: Date

  # Relationships
  belongs_to :company
  belongs_to :blood
  has_many :people

  # Access control
  attr_accessible :active, :title, :content, :quantity, :expired_at,
    :company_id, :company, :blood, :blood_id

  # Validations
  validates_presence_of :title, :content, :quantity, :expired_at, :company,
    :blood

  # Others
  private
  def generate_slug
    title.parameterize
  end
end