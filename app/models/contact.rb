class Contact
  include Mongoid::Document
  include Mongoid::Timestamps

  field :phone, type: String
  field :ddd_phone, type: Integer
  field :cellphone, type: String
  field :ddd_cellphone, type: Integer
  field :email, type: String

  #validations
  validates_inclusion_of :ddd_phone, in: Ddd.possibles
  validates_presence_of :ddd_phone, :phone, unless: :cellphone?
  validates_inclusion_of :ddd_cellphone, in: Ddd.possibles
  validates_presence_of :ddd_cellphone, :cellphone, unless: :phone?

  #relationship
  belongs_to :contactable, polymorphic: true
end