namespace :alert do
  namespace :campaign do

    puts 'Observing campaigns and months of shooting in months'
    task week: :environment do
      for campaign in Campaign.actives
        if campaign.expired_at.to_date > (Time.now + 1.week).to_date
          for person_campaign in campaign.person_campaigns.actives
            #Resque.enqueue(PersonCampaigns::Week, person_campaign.id)
          end
        end
      end
    end

    puts 'Observing campaigns and firing from day to day'
    task day: :environment do
      for campaign in Campaign.actives
        if campaign.expired_at.to_date > (Time.now + 1.day).to_date
          for person_campaign in campaign.person_campaigns.actives
            #Resque.enqueue(PersonCampaigns::Day, person_campaign.id)
          end
        end
      end
    end

    puts 'Observing campaigns and firing hourly'
    task hour: :environment do
      for campaign in Campaign.actives
        if campaign.expired_at.to_date > (Time.now + 1.hour).to_date
          for person_campaign in campaign.person_campaigns.actives
            #Resque.enqueue(PersonCampaigns::Hour, person_campaign.id)
          end
        end
      end
    end
  end
end