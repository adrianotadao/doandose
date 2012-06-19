class PersonNotification

  include Mongoid::Document
  
  field :confirmed_at, :type => Time
  
  #relationship
  belongs_to :person
  belongs_to :notification
  
  #validations
  validates_presence_of :person, :notification
  validates_associated :person, :notification

end