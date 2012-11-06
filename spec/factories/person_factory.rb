FactoryGirl.define do
  factory :person do
    donor { [true, false].sample }
    name { Faker::Name.first_name }
    surname { Faker::Name.last_name }
    sex { %w(f m).sample }
    weight { rand(999) + 1 }
    height { rand(999) + 1 }
    birthday { Date.today }
    observations { Faker::Lorem.paragraphs.first }

    blood
    contact
    address
    user
  end
end