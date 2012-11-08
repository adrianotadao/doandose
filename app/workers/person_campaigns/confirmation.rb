class PersonCampaigns::Confirmation
  @queue = "confirm_email_person_campaign_#{Rails.env}"

  def self.perform(person_campaign_id)
    return unless person_campaign_id
    PersonCampaignMailer.confirm(person_campaign_id).deliver
  end
end