class Alert
  include Mongoid::Document
  include Mongoid::Timestamps

  field :participated, type: Boolean, default: false
  field :confirmed_at, type: Time
  field :canceled_at, type: Time
  field :alerted_with, type: Array, default: []

  # Access control
  attr_accessible :canceled_at, :confirmed_at, :person_id, :person, :participated

  # Relationships
  belongs_to :person

  # Scopes
  scope :by_person, lambda { |person_id| where(person_id: person_id ) }
  scope :participateds, where(participated: true )
  scope :canceleds, where(:canceled_at.ne => nil, :canceled_at.exists => true)
  scope :non_canceleds, where(:canceled_at => nil)

  # Validations
  validates_presence_of :person, :alerted_with

  # Others
  def can_send_sms
    last_sms > (Time.now - 1.hours)
  end

  def can_send_email
    last_email > (Time.now - 1.hours)
  end

  def sms_list
    source_list('sms')
  end

  def last_sms
    last_source('sms')
  end

  def sms_counter
    source_counter('sms')
  end

  def email_counter
    source_counter('email')
  end

  def email_list
    source_list('email')
  end

  def last_email
    last_source('email')
  end

  def source_counter(typo)
    p typo
    alerted_with.map{ |r| r['date'] if r['source'] == typo }.compact.size
  end

  def last_source(typo)
    alerted_with.map{ |r| r['date'] if r['source'] == typo }.compact.last
  end

  def source_list(typo)
    alerted_with.map{ |r| r if r['source'] == typo }.compact
  end

end