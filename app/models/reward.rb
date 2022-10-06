class Reward < ApplicationRecord
  belongs_to :user

  def self.get_free_coffee_reward(user:)
    Reward.create(
      user_id: user.id,
      reward_name: "Free Coffee reward",
    )
  end
end
