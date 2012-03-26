Fabricator(:blood) do
  name { sequence(:name){|sn| "#{Faker::Lorem.words.first}#{sn.to_s}" }}
end