FactoryGirl.define do
  factory :person_notification do
    person
    notification

    alerted_with { [{ source: 'sms', date: Time.now },
      { source: 'email', date: Time.now }] }

    after(:build) { |person_notification| person_notification.class.skip_callback(:create, :after, :send_email) }

    factory :person_notification_with_send_email do
      after(:create) { |person_notification| person_notification.send(:send_email) }
    end
  end
end