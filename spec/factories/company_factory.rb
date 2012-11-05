FactoryGirl.define do
  factory :company do
    name { Faker::Company.name }
    fancy_name { Faker::Name.name }
    cnpj { rand(9999) +1 }
    responsible { Faker::Name.name }

    address
    contact
    user
  end
end