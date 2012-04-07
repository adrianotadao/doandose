Fabricator(:contact) do
  email { Faker::Internet.email }
  phone { Faker::PhoneNumber.phone_number }
  cellphone { Faker::PhoneNumber.phone_number }
end