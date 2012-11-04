FactoryGirl.define do
  factory :alert do
    participated { [true, false].sample }
    confirmed_at { Time.now }
    canceled_at { Time.now }
    alerted_with { [{ source: 'sms', date: Time.now },
      { source: 'email', date: Time.now }] }
  end
end