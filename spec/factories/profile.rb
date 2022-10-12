FactoryBot.define do

  factory :profile do
    trait :with_birthday do
      birthday { Time.now }
    end

    trait :with_1_month_past_birthday do
      birthday { (Time.now) - 1.months }
    end

  end
end