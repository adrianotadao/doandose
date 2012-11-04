FactoryGirl.define do
  factory :authentication do
    provider { %w(identity facebook twitter google_oauth2).sample }

    ignore do
      users_count 1
      uid_count 1
    end

    after(:build) do |authentication, evaluator|
      if evaluator.users_count > 0
        authentication.user = FactoryGirl.build(:user,
          authentications: [authentication], authentications_count: 0)
      end

      if evaluator.uid_count > 0 && authentication.user
        authentication.uid = authentication.user.id.to_s
      end
    end

  end
end