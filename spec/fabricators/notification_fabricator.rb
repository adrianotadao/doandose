Fabricator(:notification) do
  active { [true, false].sample }
  quantity { rand(99) + 1 }
  situation { Faker::Name.name }

  company!
  blood!
end