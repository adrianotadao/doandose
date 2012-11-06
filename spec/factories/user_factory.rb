FactoryGirl.define do
  factory :user do
    sequence(:email){|i| "#{i}#{ Faker::Internet.email }" }
    password { '123' }
    password_confirmation {|user| user.password }

    ignore do
      authentications_count 1
    end

  end
end