Fabricator(:partner) do
  logo(:fabricator => :partner_logo)
  active { [true, false].sample }
  name { Faker::Company.name }
  site { "http://#{ Faker::Internet.domain_name }" }
end