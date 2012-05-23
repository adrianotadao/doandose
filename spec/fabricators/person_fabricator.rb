Fabricator(:person) do
  active { [true, false].sample }
  donor { [true, false].sample }
  name { Faker::Name.first_name }
  surname { Faker::Name.last_name }
  sex { Faker::Lorem.words.first }
  weight { rand(99) + 1 }
  height { rand(99) + 1 }
  birthday { Date.today }
  observations { Faker::Lorem.paragraphs.first }
  lat { rand(99999) + 1 }
  lng { rand(99999) + 1 }
  
  blood!
  contact!
  address!
  user!
end
