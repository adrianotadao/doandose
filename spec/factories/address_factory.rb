FactoryGirl.define do
  factory :address do
    number { rand(999) + 1}
    street { Faker::Address.street_name }
    neighborhood { Faker::Address.city }
    city { Faker::Address.city }
    zip_code { Faker::Address.zip_code }
    state { Faker::Address.city }
    complement { Faker::Address.city }
    lat { rand(99999999) + 1 }
    lng { rand(99999999) + 1 }
    loc { [rand(99999999) + 1, rand(99999999) + 1] }
  end
end