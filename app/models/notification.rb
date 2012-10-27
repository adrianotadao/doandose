class Notification
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slugify

  field :active, type: Boolean
  field :quantity, type: Integer
  field :situation, type: String
  field :title, type: String
  field :observation, type: String

  attr_accessor :blood_type, :distance

  #relationship
  belongs_to :company
  belongs_to :blood
  has_many :person_notifications, autosave: true

  #access control
  attr_accessible :quantity, :situation, :active, :blood_id, :blood,
                  :company_id, :title, :observation, :company,
                  :person_notifications_attributes, :blood_type, :distance,
                  :person_notifications

  #validations
  validates_presence_of :company, :blood, :situation, :quantity, :blood_type,
                        :person_notifications
  validates_numericality_of :quantity

  #scopes
  scope :actives, where(active: true)

  after_create :send_sms_message, :send_email_message

  def send_sms_message
    #ContactTwilio.send_sms()
  end

  def send_email_message
    person_notifications.each do |person_notification|
      person_notification.alerted_with << 'email'
      person_notification.alerted_at = Time.now
      person_notification.save
    end


    #Mailer.alerting(id).deliver

  end

  def will_participate?(person)
    person_notifications.where(:person_id => person.id).first
  end

  def remaining
    quantity - self.person_notifications.count
  end

  private
  def generate_slug
    title.parameterize
  end
end