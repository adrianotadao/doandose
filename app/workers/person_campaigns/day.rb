class PersonCampaigns::Day
  @queue = "day_email_person_campaign_#{Rails.env}"

  def self.perform(person_campaign_id)
    person_campaign = PersonCampaign.find(person_campaign_id)

    return unless person_campaign

    person_campaign.alerted_with << { source: 'email', date: Time.now }
    person_campaign.save
    PersonCampaignMailer.alerting(person_campaign_id).deliver
  end
end