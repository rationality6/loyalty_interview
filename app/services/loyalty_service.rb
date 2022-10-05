class LoyaltyService
  def initialize(user_object:)
    super
    @user = user_object
  end

  def perform() end

  def save_point(transaction_object:)
    point = (transaction_object.spend.to_f / 10).round

  end

  private

end

