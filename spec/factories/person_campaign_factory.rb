FactoryGirl.define do
  factory :person_campaign do
    person
    campaign
    alerted_with { [{ source: 'sms', date: Time.now },
      { source: 'email', date: Time.now }] }

  end
end