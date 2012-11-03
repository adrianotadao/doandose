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
  attr_accessible :body, :notification_id, :title, :company_id

  # Relationships
  belongs_to :notification
  belongs_to :company

  # Validations
  validates_presence_of :body, :notification, :title, :company

  private
  def generate_slug
    title.parameterize
  end
end