Fabricator(:testimonial) do
  person!
  company!
  active { [true, false].sample }
  name { Faker::Name.name }
  body { Faker::Lorem.paragraphs }
end