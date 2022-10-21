namespace :batch do
  desc 'batch job'
  task get_user_birth_coffee_reward: :environment do
    User.give_birthday_reward
    puts 'user birthday coffee reward batch job done'
  end

  task expire_point: :environment do
    expired_point_historys = PointHistory.where.not(created_at: year_ago..Date.current)

    expired_point_historys.each do |pointhistory|
      pointhistory.update(expired: Time.current)
    end
  end
end
