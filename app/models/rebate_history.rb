class RebateHistory < ApplicationRecord
  belongs_to :user

  def self.check_and_update_user_rebate_right(user:)
    return true if user.profile.cash_rebate_qualified

    qualification1 = PurchaseTransaction.check_user_spend_more_than_100(user: user)
    qualification2 = PurchaseTransaction.check_user_have_transactions_more_than_10(user: user)

    if qualification1 or qualification2
      user.profile.update(cash_rebate_qualified: true)
      true
    else
      false
    end
  end

  private

end