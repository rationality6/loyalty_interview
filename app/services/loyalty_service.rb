class LoyaltyService
  def initialize(user_object:)
    @user = user_object
  end

  def save_point(transaction_object:)

    # base point
    point = if transaction_object.from_foreign_country
              foreign_point_formula(spend: transaction_object.spend)
            else
              point_formula(spend: transaction_object.spend)
            end

    point_history = PointHistory.new({
                                       user_id: @user.id,
                                       purchase_transaction_id: transaction_object.id,
                                       point_earn: point,
                                     })

    point_history.save

    update_user_point_total(point: point)

    # free coffee reward
    if PointHistory.validate_accumulates_point_current_month(user: @user)
      Reward.new.get_free_coffee_reward(user: @user)
    end

    # rebate point
    if RebateHistory.check_and_update_user_rebate_right(user: @user)
      RebateHistory.new.give_user_rebate(user: @user, transaction_object: transaction_object)
    end

    # free movie tickets within 60 days
    Reward.new.check_user_free_movie_tickets(user: @user)

    point_history
  end

  private

  def update_user_point_total(point:)
    new_total_point = @user.profile.point_total + point
    @user.profile.update({ point_total: new_total_point })
  end

  def point_formula(spend:)
    (spend.to_f / 10).round
  end

  def foreign_point_formula(spend:)
    point_formula(spend: spend) * 2
  end

end

