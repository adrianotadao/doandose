FactoryGirl.define do
  factory :person_notification do
    person
    notification
    alerted_with { [{ source: 'sms', date: Time.now },
      { source: 'email', date: Time.now }] }

  end
end