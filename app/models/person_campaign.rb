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
  scope :person_campaign_count, lambda{ |campaign_id| where(campaign_id: campaign_id, canceled_at: '') }

  # Callbacks
  after_save :send_email
  after_update :undo_confirmation

  # Others
  def send_email
    if self.can_send_email
      p id
      Resque.enqueue(PersonCampaigns::Confirmation, id)
      Resque.enqueue(PersonCampaigns::Confirm, id)
    end
  end

  def undo_confirmation
    if self.canceled?
      Resque.enqueue(PersonCampaigns::UndoConfirmation, id)
    end
  end

  def non_canceled?
    self.canceled_at.blank?
  end

  def canceled?
    self.canceled_at.present?
  end
end