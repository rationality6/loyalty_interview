class Reward < ApplicationRecord
  belongs_to :user

  def self.get_free_coffee_reward(user:)
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

  def self.validate_publish_month_coffee_reward(user:)
    beginning_of_month = Date.today.beginning_of_month
    beginning_of_next_month = beginning_of_month.next_month

    has_reward = Reward
                   .where(created_at: beginning_of_month..beginning_of_next_month)
                   .where(user_id: user.id)
                   .where(reward_name: "Free Coffee reward")

    has_reward.present?
  end

  private

end
