class Information
	include Mongoid::Document
	include Mongoid::Slugify

	field :title, type: String
	field :content, type: String

	validates_presence_of :title, :content

  private
  def generate_slug
    title.parameterize
  end
end