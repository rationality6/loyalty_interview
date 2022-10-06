namespace :batch do
  desc "batch job"
  task get_user_birth_coffee_reward: :environment do
    User.give_birthday_reward
    puts "user birthday coffee reward batch job done"
  end

end

