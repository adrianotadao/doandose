class Notification

  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :active, :type => Boolean
  field :quantity, :type => Integer
  field :situation, :type => String
  field :alerted_at, :type => Time

  #relationship
  belongs_to :company
  belongs_to :blood
  has_many :person_notifications
  
  #validations
  validates_presence_of :company, :blood, :situation, :quantity, :alerted_at
  
end