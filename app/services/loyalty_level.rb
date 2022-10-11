module LoyaltyLevel
  # A standard tier customer is an end user who accumulates 0 points
  # A gold tier customer is an end user who accumulates 1000 points
  # A platinum tier customer is an end user who accumulates 5000 points

  def level_check_and_level_up(user:)
    if 1000 <= user.profile.point_total and user.profile.point_total <= 5000 and user.profile.tier == 'standard'
      give_user_airport_reward(user: user)
      level_up(user: user, tier: "gold")
    elsif 5000 <= user.profile.point_total and user.profile.tier == 'gold'
      level_up(user: user, tier: "platinum")
    end
  end

  private

  def level_up(reward = nil, user:, tier:)
    user.profile.update(tier: tier)
  end

  def give_user_airport_reward(user:)
    # 4x Airport Lounge Access Reward

    Reward.create(
      user_id: user.id,
      reward_name: "4x Airport Lounge Access Reward",
    )
  end

end