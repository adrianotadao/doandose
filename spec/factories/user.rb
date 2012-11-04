FactoryGirl.define do
  factory :user do
    sequence(:email){|i| "#{i}#{ Faker::Internet.email }" }
    password { '123' }
    password_confirmation {|user| user.password }

    ignore do
      authentications_count 1
    end

    after(:build) do |user, evaluator|
      providers = %w(identity facebook twitter windowslive)
      while user.authentications.size < evaluator.authentications_count
        used_providers = user.authentications.map(&:provider)
        provider = (providers - used_providers).sample

        user.authentications << FactoryGirl.build(:authentication,
          user: user, users_count: 0, uid: user.id, provider: provider)
      end
    end

  end
end