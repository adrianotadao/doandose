Fabricator(:company) do
  active { [true, false].sample }
  name { Faker::Company.name }
  fancy_name { Faker::Name.name }
  cnpj { rand(9999) +1 }
  responsible { Faker::Name.name }
  
  address
  contact
  
end