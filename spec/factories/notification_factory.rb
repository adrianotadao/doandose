FactoryGirl.define do
  factory :notification do
    active { [true, false].sample }
    quantity { rand(99) + 1 }
    title { Faker::Name.name }
    observation { Faker::Name.name }
    situation { %w(urgent moderate).sample }

    company
    blood
  end
end