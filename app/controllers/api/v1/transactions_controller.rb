class Api::V1::TransactionsController < ApplicationController
  def purchase
    raise "no money spending" unless params[:spend].present?

    new_transaction = Transaction.create(
      {
        spend: params[:spend]
      }
    )

    render json: { "purchase": "purchase" }
  end

  private

end



