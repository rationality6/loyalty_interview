class PointHistory < ApplicationRecord
  belongs_to :purchase_transaction

  def get_this_month_total_point(user:)
    # If the end user accumulates 100 points in one calendar month they are given a Free Coffee reward
    beginning_of_month = Date.today.beginning_of_month
    beginning_of_next_month = beginning_of_month.next_month
    monthly_objects = PointHistory
                        .where(created_at: beginning_of_month..beginning_of_next_month)
                        .where(user_id: user.id)
    this_month_total_point = monthly_objects.pluck(:point_earn).sum
    this_month_total_point
  end

  def check_user_got_coffee_reward_this_month
    # Reward.get_free_coffee_reward()
  end

end
