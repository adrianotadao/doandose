FactoryGirl.define do
  factory :contact do
    email { Faker::Internet.email }
    ddd_phone { 18 }
    phone { Faker::PhoneNumber.phone_number }
    ddd_cellphone { 18 }
    cellphone { Faker::PhoneNumber.phone_number }
  end
end