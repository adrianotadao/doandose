class Testimonial

  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :active, :type => Boolean
  field :name, :type => String
  field :body, :type => String
  
  #relationship
  belongs_to :person
  belongs_to :company

end