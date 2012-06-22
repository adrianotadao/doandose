Fabricator(:address) do
  number { rand(999) + 1}
  street { Faker::AddressUS.street_name }
  neighborhood { Faker::AddressUS.city }
  city { Faker::AddressUS.city }
  zip_code { Faker::AddressUS.zip_code }
  state { Faker::AddressUS.city }
  lat { rand(99999999) + 1 }
  lng { rand(99999999) + 1 }
end