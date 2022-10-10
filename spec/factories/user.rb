FactoryBot.define do
  factory :user do
    trait :skip_validate do
      to_create { |instance| instance.save(validate: false) }
    end

    trait :test_email do
      email { "test00@gmail.com" }
    end
  end
end
