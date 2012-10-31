class Contact
  # Includes
  include Mongoid::Document
  include Mongoid::Timestamps

  # Fields
  field :phone, type: String
  field :ddd_phone, type: Integer
  field :cellphone, type: String
  field :ddd_cellphone, type: Integer
  field :email, type: String

  # Indexes
  index({ email: 1 }, { unique: true })

  # Validations
  validates :ddd_phone, inclusion: { :in => Ddd.possibles  }, if: :ddd_phone?
  validates_presence_of :ddd_phone, :phone, unless: :cellphone?
  validates :ddd_cellphone, inclusion: { :in => Ddd.possibles  }, if: :ddd_cellphone?
  validates_presence_of :ddd_cellphone, :cellphone, unless: :phone?

  # Relationships
  belongs_to :contactable, polymorphic: true

  # Others
  def parse_to_twilio
    "+55#{ddd_cellphone}#{cellphone}"
  end
end