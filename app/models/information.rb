class Information
  # Includes
	include Mongoid::Document
	include Mongoid::Slugify

  # Fields
	field :title, type: String
	field :content, type: String

  # Validations
	validates_presence_of :title, :content

  # Others
  private
  def generate_slug
    title.parameterize
  end
end