class Person
  # Includes
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slugify

  # Fields
  field :donor, type: Boolean
  field :name, type: String
  field :surname, type: String
  field :sex, type: String
  field :weight, type: Float
  field :height, type: Float
  field :birthday, type: Date
  field :observations, type: String

  # Access control
  attr_accessible :sex, :donor, :name, :surname, :weight, :height, :birthday,
    :observations, :address_attributes, :contact_attributes, :user_attributes,
    :blood, :blood_id

  # Relationships
  belongs_to :blood
  has_many :person_notifications, dependent: :destroy, autosave: true
  has_many :person_campaigns, dependent: :destroy, autosave: true
  has_many :alerts, dependent: :destroy, autosave: true
  has_one :address, as: :addressable, dependent: :destroy, autosave: true
  has_one :contact, as: :contactable, dependent: :destroy, autosave: true
  has_one :user, as: :authenticable, dependent: :destroy, autosave: true
  accepts_nested_attributes_for :address, :contact, :user, allow_destoy: true

  # Validations
  validates_inclusion_of :donor,  in: [true, false]
  validates_inclusion_of :sex,  in: %(f m)
  validates_presence_of :name, :weight, :height, :surname, :sex, :birthday,
    :contact, :address, :blood, :user
  validates_length_of :name, in: 2..30
  validates :weight, :height, numericality: true

  # Scopes
  scope :actives, where(active: true)
  scope :donors, where(donor: true)

  # Others
  def blood_donors
    BloodMatch.donor(blood.name)
  end

  def birthdate=value
    super value
  rescue
    nil
  end

  private
  def generate_slug
    name.parameterize
  end
end