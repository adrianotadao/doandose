class Contact
  include Mongoid::Document
  include Mongoid::Timestamps

  field :phone, type: String
  field :ddd_phone, type: Integer
  field :cellphone, type: String
  field :ddd_cellphone, type: Integer
  field :email, type: String

  index({ email: 1 }, { unique: true })

  #validations
  validates_inclusion_of :ddd_phone, in: Ddd.possibles, if: :ddd_phone?
  validates_presence_of :ddd_phone, :phone, unless: :cellphone?
  validates_inclusion_of :ddd_cellphone, in: Ddd.possibles, if: :ddd_cellphone
  validates_presence_of :ddd_cellphone, :cellphone, unless: :phone?
  validates :phone, :ddd_phone, :cellphone, :ddd_cellphone, numericality: true
  validates_length_of :phone, :cellphone, in: 8..9
  validates_length_of :ddd_phone, :ddd_cellphone, in: 2..2

  # validates_presence_of :email, if: :admin_signed_in?
  # validates_presence_of :email, if: :admin_signed_in?
  # validates_format_of :email, with: /^([^@\s]+[a-zA-Z0-9._-])@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, if: :admin_signed_in?
  # validates_uniqueness_of :email, case_sensitive: false, if: :admin_signed_in?

  #relationship
  belongs_to :contactable, polymorphic: true

  def parse_to_twilio
    "+55#{ddd_cellphone}#{cellphone}"
  end
end