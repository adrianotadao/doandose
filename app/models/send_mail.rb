class SendMail
  # Includes
  include ActiveModel::Validations
  include Mongoid::State

  # Accessors
  attr_accessor :name, :message, :subject, :email

  # Validations
  validates_presence_of :name, :message, :email, :subject
  validates :email, presence: true,
    format: { with: /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }

  # Others
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