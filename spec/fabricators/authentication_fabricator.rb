Fabricator(:authentication) do
  user!
  uid { sequence(:uid){|sn| rand(9999) + sn.to_i } }
  provider { sequence(:provider){|sn| "#{Faker::Name.name}#{sn.to_s}" }}
end