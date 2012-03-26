Fabricator(:user) do
  authentications!(:count => 1) do |parent, i|
    Fabricate(:authentication, :user => parent)
  end
  
  name { Faker::Name.name }
  email { sequence(:email){|sn| "#{ Faker::Internet.email }#{ sn.to_s }" }}
  password { '123' }
  password_confirmation {|user| user.password }
end