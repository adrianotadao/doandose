class SendMail
  include ActiveModel::Validations
  include Mongoid::State

  attr_accessor :name, :message, :subject, :email
  validates_presence_of :name, :message, :email, :subject
  validates :email, presence: true,
    format: { with: /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }

  def initialize(attributes = {})
    @name = attributes[:name]
    @message = attributes[:message]
    @subject = attributes[:subject]
    @email = attributes[:email]
  end

  def persisted?
    false
  end
end