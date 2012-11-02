class PersonCampaigns::Hour
  @queue = "hour_sms_person_campaign_#{Rails.env}"

  def self.perform(person_campaign_id)
    person_campaign = PersonCampaign.find(person_campaign_id)

    return unless person_campaign

    person_campaign.alerted_with << { source: 'sms', date: Time.now }
    person_campaign.save

    call_number = person_campaign.person.contact.parse_to_twilio
    #ContactTwilio.send_sms([call_number], 'Falta 1 hora para a campanha começar!')
  end
end