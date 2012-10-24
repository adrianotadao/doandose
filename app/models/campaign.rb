class Campaign
  include Mongoid::Document
  include Mongoid::Slugify

  field :active, type: Boolean, default: true
  field :title, type: String
  field :content, type: String
  field :quantity, type: Integer
  field :expired_at, type: Date

  belongs_to :company
  belongs_to :blood
  has_many :people

  attr_accessible :active, :title, :content, :quantity, :expired_at,
                  :company_id, :company, :blood, :blood_id

  validates_presence_of :title, :content, :quantity, :expired_at, :company, :blood

  private
  def generate_slug
    title.parameterize
  end
end