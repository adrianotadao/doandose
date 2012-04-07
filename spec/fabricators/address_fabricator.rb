Fabricator(:address) do
  number { rand(999) + 1}
  street { Faker::Address.street_name }
  neighborhood { Faker::Address.city }
  city { Faker::Address.city }
  zip_code { Faker::Address.zip_code }
  state { Faker::Address.city }
end