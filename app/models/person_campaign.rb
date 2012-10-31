class PersonCampaign < Alert
  # Relationship
  belongs_to :campaign

  # Access control
  attr_accessible :campaign_id, :campaign

  # Validations
  validates_presence_of :campaign
end