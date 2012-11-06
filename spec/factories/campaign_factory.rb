FactoryGirl.define do
  factory :campaign do
    active { [true, false].sample }
    title { Faker::Lorem.sentence }
    content { Faker::Lorem.paragraph }
    quantity { rand(99) + 1 }
    expired_at { Time.now + rand(9).days }

    company
    blood
  end
end