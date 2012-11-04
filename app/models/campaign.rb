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
  has_many :person_campaigns, dependent: :destroy, autosave: true

  # Access control
  attr_accessible :active, :title, :content, :quantity, :expired_at,
    :company_id, :company, :blood, :blood_id

  # Validations
  validates_presence_of :title, :content, :quantity, :expired_at, :company,
    :blood

  # Scopes
  scope :actives, where(active: true)
  scope :compatibles_by, ->(bloods) { where(:blood_id.in => bloods) }

  def campaign_confirmed(user)
     self.person_campaigns.by_person( user ).exists?
  end

  def will_participate?(person)
    person_campaigns.non_canceleds.where(:person_id => person.id).first
  end

  # Others
  private
  def generate_slug
    title.parameterize
  end
end