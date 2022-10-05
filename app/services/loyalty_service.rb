class LoyaltyService
  def initialize(user_object:)
    @user = user_object
  end

  def save_point(transaction_object:)
    point = point_formula(transaction_object.spend)

    point_history = PointHistory.new({
                                       user_id: @user.id,
                                       transaction_id: transaction_object.id,
                                       point_earn: point,
                                     })

    point_history.save
    point_history
  end

  private

  def point_formula(spend)
    (spend.to_f / 10).round
  end
end

