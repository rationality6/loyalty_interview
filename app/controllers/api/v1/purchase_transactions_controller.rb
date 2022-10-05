class Api::V1::PurchaseTransactionsController < ApplicationController
  before_action :set_sign_in_user_mocking
  before_action :set_loyalty_service

  def purchase
    raise "no spend params" unless params[:spend].present?
    params[:from_foreign_country] = false unless params[:from_foreign_country].present?

    new_transaction = PurchaseTransaction.create(
      {
        user_id: @current_user.id,
        spend: params[:spend],
        from_foreign_country: params[:from_foreign_country]
      }
    )

    @loyalty_service_instanse.save_point(transaction_object: new_transaction)

    render json: new_transaction
  end

  private

  def set_sign_in_user_mocking
    @current_user = User.first
  end

  def set_loyalty_service
    @loyalty_service_instanse = LoyaltyService.new(user_object: @current_user)
  end

end



