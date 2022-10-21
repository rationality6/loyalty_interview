FactoryBot.define do
  factory :user do
    to_create { |instance| instance.save(validate: false) }

    trait :with_profile do
      profile { build(:profile, :with_birthday) }
    end

    trait :with_past_birth_profile do
      profile { build(:profile, :with_1_month_past_birthday) }
    end

    trait :test_email do
      email { 'test00@gmail.com' }
    end

    trait :test_email01 do
      email { 'test01@gmail.com' }
    end
  end
end
