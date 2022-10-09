class Reward < ApplicationRecord
  belongs_to :user

  def get_free_coffee_reward(user:)
    return "user already got this month coffee coupon" if validate_publish_month_coffee_reward(user: user)

    Reward.create(
      user_id: user.id,
      reward_name: "Free Coffee reward",
    )
  end

  def self.give_birthday_reward()
    beginning_of_month = Date.today.beginning_of_month
    beginning_of_next_month = beginning_of_month.next_month
    birthday_users = Profile.where(birthday: beginning_of_month..beginning_of_next_month)

    birthday_users.each do |birthday_user|
      Reward.create(
        user_id: birthday_user.user_id,
        reward_name: "Birth day Free Coffee reward",
      )
    end
    birthday_users
  end

  def validate_publish_month_coffee_reward(user:)
    beginning_of_month = Date.today.beginning_of_month
    beginning_of_next_month = beginning_of_month.next_month

    has_reward = Reward
                   .where(created_at: beginning_of_month..beginning_of_next_month)
                   .where(user_id: user.id)
                   .where(reward_name: "Free Coffee reward")

    has_reward.present?
  end

  def check_user_free_movie_tickets(user:)
    return "already have one" if validate_user_got_free_movie_tickets(user: user)
    return "not within days from first transaction" unless validate_user_from_transaction_within_days(user: user, days: 60)

    if total_user_spend_from_transaction(user: user)
      give_user_movie_reward(user: user)
    else
      "not enough to get movie tickets"
    end
  end

  private

  def validate_user_got_free_movie_tickets(user:)
    Reward.where(
      user_id: user.id,
      reward_name: "A Free Movie Tickets"
    ).present?
  end

  def validate_user_from_transaction_within_days(user:, days:)
    first_transaction = PurchaseTransaction.where(user_id: user.id).first
    return false unless first_transaction.present?

    date_count_from_user_created_at = (Date.current - first_transaction.created_at.to_date).to_i
    date_count_from_user_created_at < days
  end

  def total_user_spend_from_transaction(user:)
    first_transaction = PurchaseTransaction.where(user_id: user.id).first
    return false unless first_transaction.present?

    total_sum = PurchaseTransaction.where(created_at: first_transaction.created_at..Time.current).pluck(:spend).sum
    total_sum >= 1000
  end

  def give_user_movie_reward(user:)
    Reward.create(
      user_id: user.id,
      reward_name: "A Free Movie Tickets",
    )
  end

end
