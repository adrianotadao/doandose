class Blood
  include Mongoid::Document
  
  field :name, :type => String
  
  #relationship
  has_many :people

  #validations
  validates_presence_of :name

end
