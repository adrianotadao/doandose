FactoryGirl.define do
  factory :blood do
    name { Faker::Name.name }
  end
end