module LoyaltyLevel
  # A standard tier customer is an end user who accumulates 0 points
  # A gold tier customer is an end user who accumulates 1000 points
  # A platinum tier customer is an end user who accumulates 5000 points

  def level_check_and_level_up(user:)
    if 1000 <= user.profile.point_total and user.profile.point_total <= 5000
      level_up(user: user, tier: "gold")
    elsif 5000 <= user.profile.point_total
      level_up(user: user, tier: "platinum")
    end
  end

  private

  def level_up(reward = nil, user:, tier:)
    user.profile.update(tier: tier)
  end

  def reward
    # 4x Airport Lounge Access Reward
  end

end