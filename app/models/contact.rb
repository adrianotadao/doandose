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
  validates :ddd_phone, inclusion: { :in => Ddd.possibles  }, if: :ddd_phone?
  validates_presence_of :ddd_phone, :phone, unless: :cellphone?
  validates :ddd_cellphone, inclusion: { :in => Ddd.possibles  }, if: :ddd_cellphone?
  validates_presence_of :ddd_cellphone, :cellphone, unless: :phone?

  #relationship
  belongs_to :contactable, polymorphic: true

  def parse_to_twilio
    "+55#{ddd_cellphone}#{cellphone}"
  end
end