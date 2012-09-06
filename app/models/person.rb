class Person
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug

  field :active, type: Boolean, default: true
  field :donor, type: Boolean
  field :name, type: String
  field :surname, type: String
  field :sex, type: Boolean
  field :weight, type: Float
  field :height, type: Float
  field :birthday, type: String
  field :observations, type: String

  slug :name

  #access control
  attr_accessible :address, :address_attributes, :contact, :contact_attributes,
                  :user, :user_attributes, :name, :donor, :surname, :sex, :weight,
                  :height, :birthday, :observations, :blood, :blood_id, :email,
                  :phone, :cellphone, :zip_code, :street, :number, :neighborhood,
                  :city, :state, :provider, :uid, :email

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
end