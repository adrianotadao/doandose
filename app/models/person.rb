class Person
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slugify

  field :donor, type: Boolean
  field :name, type: String
  field :surname, type: String
  field :sex, type: String
  field :weight, type: Float
  field :height, type: Float
  field :birthday, type: Date
  field :observations, type: String

  #access control
  attr_accessible :sex, :donor, :name, :surname, :weight, :height, :birthday,
    :observations, :address_attributes, :contact_attributes, :user_attributes,
    :blood, :blood_id, :lat, :lng, :loc

  #relationship
  belongs_to :blood
  belongs_to :company
  has_many :person_notifications
  has_one :address, as: :addressable, dependent: :destroy, autosave: true
  has_one :contact, as: :contactable, dependent: :destroy, autosave: true
  has_one :user, as: :authenticable, dependent: :destroy, autosave: true
  accepts_nested_attributes_for :address, :contact, :user, allow_destoy: true

  #validations
  validates_presence_of :name, :weight, :height, :surname, :sex, :birthday,
                        :contact, :address, :blood, :user

  #scopes
  scope :actives, where: { active: true }
  scope :donors, where: { donor: true }

  def update_location
    return if self.address.lat.blank? || self.address.lng.blank?
    self.address.update_attributes(loc: [self.address.lat, self.address.lng])
  end

  private
  def generate_slug
    name.parameterize
  end
end