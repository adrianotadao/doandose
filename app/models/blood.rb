class Blood
  # Includes
  include Mongoid::Document
  include Mongoid::Slugify

  # Fields
  field :name, type: String

  # Relationships
  has_many :people
  has_many :notifications

  # Validations
  validates_presence_of :name
  validates_uniqueness_of :name

  # Other
  private
  def generate_slug
    name.parameterize
  end

end