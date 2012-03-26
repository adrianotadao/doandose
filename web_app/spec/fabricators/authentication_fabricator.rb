Fabricator(:authentication) do
  user!
  uid { sequence(:uid){|sn| rand(9999) + sn.to_i } }
  provider { sequence(:uid){|sn| "#{['identity', 'facebook', 'twitter'].sample}#{sn.to_s}" }}
end