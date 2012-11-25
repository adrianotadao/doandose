class Notification
  # Includes
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slugify

  # Fields
  field :active, type: Boolean, default: true
  field :quantity, type: Integer
  field :situation, type: String
  field :title, type: String
  field :observation, type: String
  field :closed_at, type: Time
  field :result, type: String

  # Accessors
  attr_accessor :blood_type, :distance

  # Relationships
  belongs_to :company
  belongs_to :blood
  has_many :person_notifications, dependent: :destroy, autosave: true

  # Access control
  attr_accessible :quantity, :situation, :active, :blood_id, :blood,
    :company_id, :title, :observation, :company, :person_notifications_attributes,
    :blood_type, :distance, :person_notifications

  # Validations
  validates_presence_of :company, :blood, :situation, :quantity, :person_notifications, :title
  validates_presence_of :blood_type, if: :blood_required
  validates_numericality_of :quantity
  validates_inclusion_of :situation, in: %w(urgent moderate)

  # Scopes
  scope :actives, where(active: true)
  scope :compatibles_by, ->(bloods) { where(:blood_id.in => bloods) }

  # Callbacks
  after_create :send_sms, :send_email

  # Others
  def blood_required
    blood.blank? && new_record?
  end

  def send_sms
    Resque.enqueue(Notifications::SMS, self.id)
  end

  def send_email
    Resque.enqueue(Notifications::Email, self.id)
  end

  def will_participate(person)
    person_notifications.by_person(person.id).notification_contains(self.id).first
  end

  def remaining
    quantity - self.person_notifications.count
  end

  def notification_confirmed(user)
     self.person_notifications.by_person( user ).exists?
  end

  private
  def generate_slug
    title.parameterize
  end
end