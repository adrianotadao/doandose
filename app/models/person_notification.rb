class PersonNotification

  include Mongoid::Document
  
  field :confirmed_at, :type => Time
  
  #access control
  attr_accessible :confirmed_at
  
  #relationship
  belongs_to :person
  belongs_to :notification
  
  #validations
  validates_presence_of :person, :notification

end