namespace :alert do
  namespace :campaign do

    task week: :environment do
      for campaign in Campaign.actives
        if campaign.created_at > Time.now + 1.week
          for person_campaign in campaign.person_campaigns.actives
            Resque.enqueue(PersonCampaigns::Week, person_campaign.id)
          end
        end
      end
    end

    task day: :environment do
      for campaign in Campaign.actives
        if campaign.created_at > Time.now + 1.day
          for person_campaign in campaign.person_campaigns.actives
            Resque.enqueue(PersonCampaigns::Day, person_campaign.id)
          end
        end
      end
    end

    task hour: :environment do
      for campaign in Campaign.actives
        if campaign.created_at > Time.now + 1.hour
          for person_campaign in campaign.person_campaigns.actives
            Resque.enqueue(PersonCampaigns::Hour, person_campaign.id)
          end
        end
      end
    end
  end
end