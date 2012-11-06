class PersonCampaign < Alert
  # Relationship
  belongs_to :campaign
  belongs_to :person

  # Access control
  attr_accessible :campaign_id, :campaign, :person, :person_id

  # Validations
  validates_presence_of :campaign, :person

  # Scopes
  scope :campaign_contains,  lambda { |campaign_id| where( campaign_id: campaign_id ) }

  # Callbacks
  after_save :send_email

  # Others
  def send_email
    return if self.campaign.blank? && self.person.blank?
    if self.canceled?
      CompanyCampaignMailer.undo_confirmation(self.campaign.id, self.person.id).deliver
    else
      CompanyCampaignMailer.confirmation(self.campaign.id).deliver
    end
  end

  def send_email_undo_confirm
    return if self.notification.blank? && self.person.blank?
    CompanyNotificationMailer.undo_confirmation(self.notification.id, self.person.id).deliver
  end

  def non_canceled?
    self.canceled_at.blank?
  end

  def canceled?
    self.canceled_at.present?
  end
end