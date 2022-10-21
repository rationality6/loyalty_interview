class PointHistory < ApplicationRecord
  belongs_to :purchase_transaction

  def get_this_month_total_point(user:)
    # If the end user accumulates 100 points in one calendar month they are given a Free Coffee reward
    beginning_of_month = Date.today.beginning_of_month
    beginning_of_next_month = beginning_of_month.next_month
    monthly_objects = PointHistory
                      .where(created_at: beginning_of_month..beginning_of_next_month)
                      .where(user_id: user.id)

    monthly_objects.pluck(:point_earn).sum
  end

  def self.validate_accumulates_point_current_month(user:)
    beginning_of_month = Date.today.beginning_of_month
    beginning_of_next_month = beginning_of_month.next_month

    point_earn_current_month = PointHistory
                               .where(created_at: beginning_of_month..beginning_of_next_month)
                               .where(user_id: user.id)
                               .pluck(:point_earn)
                               .sum

    100 <= point_earn_current_month
  end
end
