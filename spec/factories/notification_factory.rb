FactoryGirl.define do
  factory :notification do
    active { [true, false].sample }
    quantity { rand(99) + 1 }
    title { Faker::Name.name }
    observation { Faker::Lorem.paragraphs.first }
    situation { %w(urgent moderate).sample }
    blood_type { 'A+' }

    company
    blood

    after(:build) do |notification, evaluator|
      FactoryGirl.build(:person_notification, notification: notification)
    end

    before(:create) { |notification| notification.class.skip_callback(:create, :after, :send_sms) }
    before(:create) { |notification| notification.class.skip_callback(:create, :after, :send_email) }
  end
end