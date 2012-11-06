FactoryGirl.define do
  factory :person_notification do
    person
    notification
    alerted_with { [{ source: 'sms', date: Time.now },
      { source: 'email', date: Time.now }] }

    before(:create) { |person_notification| person_notification.class.skip_callback(:create, :after, :send_email_confirmation) }
  end
end