module MailersHelper
  def notification_counter(notification)
    PersonNotification.person_notification_count(notification.id).count
  end

  def campaign_counter(campaign)
    PersonCampaign.person_campaign_count(campaign.id).count
  end
end