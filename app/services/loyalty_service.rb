class LoyaltyService
  def initialize(user_object:)
    @user = user_object
  end

  def save_point(transaction_object:)
    point = point_formula(transaction_object.spend)

    point_history = PointHistory.new({
                                       user_id: @user.id,
                                       purchase_transaction_id: transaction_object.id,
                                       point_earn: point,
                                     })

    point_history.save

    update_user_point_total(point: point)

    point_history
  end

  private

  def update_user_point_total(point:)
    new_total_point = @user.profile.point_total + point
    @user.profile.update({ point_total: new_total_point })
  end

  def point_formula(spend)
    (spend.to_f / 10).round
  end
end

