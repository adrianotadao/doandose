class Testimonial
  # Includes
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slugify

  # Fields
  field :active, type: Boolean, default: false
  field :title, type: String
  field :body, type: String

  # Access control
  attr_accessible :body, :notification_id, :title, :company_id, :active

  # Scopes
  scope :actives, where(active: true)

  # Relationships
  belongs_to :notification
  belongs_to :company

  # Validations
  validates_presence_of :body, :notification, :title, :company
  validates_length_of :body, in: 120..130

  private
  def generate_slug
    title.parameterize
  end
end