class IndicationFriend
  include ActiveModel::Validations
  include Mongoid::State

  attr_accessor :message, :subject, :email, :sender
  validates_presence_of :message, :email, :subject, :sender
  validates :email, presence: true,
    format: { with: /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }

  def initialize(attributes = {})
    @message = attributes[:message]
    @subject = attributes[:subject]
    @email = attributes[:email]
    @sender = attributes[:sender]
  end

  def persisted?
    false
  end

  def to_key
    persisted? ? false : nil
  end
end