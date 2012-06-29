class Person

  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug

  field :active, :type => Boolean, :default => true
  field :donor, :type => Boolean
  field :name, :type => String
  field :surname, :type => String
  field :sex, :type => Boolean
  field :weight, :type => Float
  field :height, :type => Float
  field :birthday, :type => String  
  field :observations, :type => String

  slug :name

  #access control
  attr_accessible :address, :address_attributes, :contact, :contact_attributes, :user, :user_attributes, :name, 
                  :donor, :surname, :sex, :weight, :height, :birthday, :observations, :blood, :blood_id, :email, :phone, 
                  :cellphone, :zip_code, :street, :number, :neighborhood, :city, :state, :provider, :uid, :email

  #relationship
  belongs_to :blood
  belongs_to :company
  has_one :address, :as => :addressable, :dependent => :destroy, :autosave => true
  has_one :contact, :as => :contactable, :dependent => :destroy, :autosave => true
  has_one :user, :as => :authenticable, :dependent => :destroy, :autosave => true
  has_many :person_notifications
  
  accepts_nested_attributes_for :address, :contact, :user, :allow_destoy => true

  #validations
  #validates_presence_of :name, :weight, :height, :surname, :sex, :birthday, :contact, :address, :blood, :if => lambda { |c| c.current_step == 'personal' }
  #validates_presence_of :user, :if => lambda { |c| c.current_step == 'user' }

  attr_writer :current_step

  #scopes
  scope :actives, :where => { :active => true }

  #others
  def current_step
    @current_step || steps.first
  end
  
  def steps
    %w[user personal confirmation]  
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

  def first_step
    steps.first
  end

  def all_valid?
    steps.all? do |step|
      self.current_step = step
      valid?
    end
  end
end