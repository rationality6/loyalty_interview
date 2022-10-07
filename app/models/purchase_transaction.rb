class PurchaseTransaction < ApplicationRecord
  belongs_to :user
  has_one :point_history

  def self.new_transaction(user:, params:)
    purchase_transaction = PurchaseTransaction.create(
      {
        user_id: user.id,
        spend: params[:spend],
        from_foreign_country: params[:from_foreign_country]
      }
    )
    purchase_transaction
  end

  def self.check_user_spend_more_than_100(user:)
    100 <= PurchaseTransaction.where(user_id: user.id).pluck(:spend).sum
  end

  def self.check_user_have_transactions_more_than_10(user:)
    10 <= PurchaseTransaction.where(user_id: user.id).count
  end

  private

end
