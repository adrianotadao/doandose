class Person

  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :active, :type => Boolean
  field :donor, :type => Boolean
  field :name, :type => String
  field :surname, :type => String
  field :sex, :type => String
  field :weight, :type => Float
  field :height, :type => Float
  field :birthday, :type => String  
  field :observations, :type => String

  field :lat, :type => String
  field :lng, :type => String

  #relationship
  belongs_to  :blood
  has_one     :address, as: :addressable,   dependent: :destroy, autosave: true
  has_one     :contact, as: :contactable,   dependent: :destroy, autosave: true
  has_one     :user,    as: :authenticable, dependent: :destroy, autosave: true
  has_many    :person_notifications

  #validations :user
  validates_presence_of :user, :if => lambda { |c| c.current_step == 'user' }
  validates_presence_of :name, :surname, :sex, :birthday, :contact, :address, :if => lambda { |c| c.current_step == 'information' }


  accepts_nested_attributes_for :address, :contact, :user, :allow_destoy => true
  attr_accessible :address, :address_attributes, :contact, :contact_attributes, :user, :user_attributes, :name, 
                  :donor, :surname, :sex, :weight, :height, :birthday, :observations, :blood, :email, :phone, 
                  :cellphone, :zip_code, :street, :number, :neighborhood, :city, :state, :provider, :uid, :email, 
                  :username
  attr_writer :current_step

  #others
  def current_step
    @current_step || steps.first
  end
  
  def steps
    %w[user information confirmation]  
  end

  def next_step
    self.current_step = steps[ steps.index(current_step) + 1]
  end

  def previous_step
    self.current_step = steps[ steps.index(current_step) - 1]
  end

  def first_step?
    current_step == steps.first  
  end

  def last_step?
    current_step == steps.last  
  end

  def all_valid?
    steps.all? do |step|
      self.current_step = step
      valid?
    end
  end
end
