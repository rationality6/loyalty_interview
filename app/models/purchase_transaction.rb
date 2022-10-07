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
end
