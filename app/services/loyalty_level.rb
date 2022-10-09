module LoyaltyLevel
  # A standard tier customer is an end user who accumulates 0 points
  # A gold tier customer is an end user who accumulates 1000 points
  # A platinum tier customer is an end user who accumulates 5000 points

  def level_check_and_lovel_up(user:)
    if 1000 <= user.profile.total_point
      level_up(user: user, tier: "gold")
    elsif 5000 <= user.profile.total_point
      level_up(user: user, tier: "platinum")
    end
  end

  private

  def level_up(user:, tier:)
    user.update(tier: tier)
  end

end