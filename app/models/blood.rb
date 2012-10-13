class Blood
  include Mongoid::Document
  include Mongoid::Slugify

  field :name, type: String

  #relationship
  has_many :people
  has_many :notifications

  #validations
  validates_presence_of :name
  validates_uniqueness_of :name

  private
  def generate_slug
    name.parameterize
  end

end