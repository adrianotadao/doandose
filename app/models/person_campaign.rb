class PersonCampaign < Alert
  # Relationship
  belongs_to :campaign
  belongs_to :person

  # Access control
  attr_accessible :campaign_id, :campaign, :person, :person_id

  # Validations
  validates_presence_of :campaign

  # Scopes
  scope :campaign_contains,  lambda { |campaign_id| where( campaign_id: campaign_id ) }

  # Callbacks
  after_save :send_email

  # Others
  def send_email

  end

  def send_email_undo_confirm

  end

  def non_canceled?
    self.canceled_at.blank?
  end

  def canceled?
    self.canceled_at.present?
  end
end