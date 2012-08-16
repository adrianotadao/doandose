class Information
	include Mongoid::Document
	include Mongoid::Slug

	field :title, :type => String
	field :content, :type => String

	slug :title

	validates_presence_of :title, :content
end