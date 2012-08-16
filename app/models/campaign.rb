class Campaign
	include Mongoid::Document
	include Mongoid::Slug

	field :active, :type => Boolean
	field :title, :type => String
	field :content, :type => String
	field :quantity, :type => Integer
	field :expired_at, :type => Date

	belongs_to :company
	belongs_to :blood
	has_many :people

	validates_presence_of :title, :content, :quantity, :expired_at

end