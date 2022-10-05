class Api::V1::TransactionsController < ApplicationController
  before_action :sign_in_user_mocking
  def purchase
    raise "no spend params" unless params[:spend].present?
    params[:from_foreign_country] = false unless params[:from_foreign_country].present?

    new_transaction = Transaction.create(
      {
        user_id: current_user.id,
        spend: params[:spend],
        from_foreign_country: params[:from_foreign_country]
      }
    )

    render json: new_transaction
  end

  private

  def sign_in_user_mocking
    @current_user = User.first
  end

end



