require 'rails_helper'

RSpec.describe "PurchaseTransactions", type: :request do
  let!(:test_user) {
    user = User.new
    user.save(validate: false)
    user
  }

  let!(:test_user_profile) {
    profile = Profile.new({ user_id: test_user.id })
    profile.save()
    profile
  }

  it "when no params spend" do
    expect {
      post purchase_purchase_transactions_url, params: {}
    }.to raise_error("no spend params")
  end

  it "status check" do
    post purchase_purchase_transactions_url, params: { spend: 60 }
    expect(response.status).to(eq(200))
  end

  it "created and returned purchase_transactions" do
    post purchase_purchase_transactions_url, params: { spend: 60 }
    expect(response.body).to include_json({
                                            spend: 60,
                                            user_id: test_user.id
                                          })
  end

  describe "10% point earn" do
    it "when 250" do
      post purchase_purchase_transactions_url, params: { spend: 250 }
      transaction_id = JSON.parse(response.body)['id']
      point_history = PointHistory.find(transaction_id)
      expect(point_history.point_earn).to eq(25)
    end

    it "when 530" do
      post purchase_purchase_transactions_url, params: { spend: 530 }
      transaction_id = JSON.parse(response.body)['id']
      point_history = PointHistory.find(transaction_id)
      expect(point_history.point_earn).to eq(53)
    end
  end

  describe "from_foreign_country x 2" do
    it "when 250" do
      post purchase_purchase_transactions_url, params: { spend: 250, from_foreign_country: true }
      transaction_id = JSON.parse(response.body)['id']
      point_history = PointHistory.find(transaction_id)
      expect(point_history.point_earn).to eq(50)
    end

    it "when 530" do
      post purchase_purchase_transactions_url, params: { spend: 530, from_foreign_country: true }
      transaction_id = JSON.parse(response.body)['id']
      point_history = PointHistory.find(transaction_id)
      expect(point_history.point_earn).to eq(106)
    end
  end

  describe "If the end user accumulates 100 points in one calendar month they are given a Free Coffee reward" do
    it "user already have coffee reward current month" do
      post purchase_purchase_transactions_url, params: { spend: 1000 }
      expect {
        post purchase_purchase_transactions_url, params: { spend: 1000 }
      }.to raise_error("user already got this month coffee coupon")
    end

    it "user will get coffee reward current month" do
      expect(Reward.validate_publish_month_coffee_reward(user: test_user)).to eq(false)
      post purchase_purchase_transactions_url, params: { spend: 1000 }
      expect(Reward.validate_publish_month_coffee_reward(user: test_user)).to eq(true)
    end
  end

end
