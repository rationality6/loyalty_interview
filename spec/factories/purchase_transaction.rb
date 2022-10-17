FactoryBot.define do
  factory :purchase_transaction do
    spend { 0 }

    trait :past_60_days do
      # added 1 more day as time differences
      created_at { Time.now - (61.days) }
    end

  end
end
