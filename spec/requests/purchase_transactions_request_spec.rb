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
    it "user will get coffee reward current month" do
      expect(Reward.new.validate_publish_month_coffee_reward(user: test_user)).to eq(false)
      post purchase_purchase_transactions_url, params: { spend: 1000 }
      expect(Reward.new.validate_publish_month_coffee_reward(user: test_user)).to eq(true)
    end
  end

  describe "rebate right" do
    it "qualified user will have rebate right when spend more than $100" do
      result = RebateHistory.check_and_update_user_rebate_right(user: test_user)
      expect(result).to eq(false)

      post purchase_purchase_transactions_url, params: { spend: 100 }

      result = RebateHistory.check_and_update_user_rebate_right(user: test_user)
      expect(result).to eq(true)
    end

    it "user will not have rebate right when spend less than $100" do
      result = RebateHistory.check_and_update_user_rebate_right(user: test_user)
      expect(result).to eq(false)

      post purchase_purchase_transactions_url, params: { spend: 99 }

      result = RebateHistory.check_and_update_user_rebate_right(user: test_user)
      expect(result).to eq(false)
    end

    it "qualified user will have rebate right when spend more than 10 transactions" do
      result = RebateHistory.check_and_update_user_rebate_right(user: test_user)
      expect(result).to eq(false)

      10.times {
        post purchase_purchase_transactions_url, params: { spend: 1 }
      }

      result = RebateHistory.check_and_update_user_rebate_right(user: test_user)
      expect(result).to eq(true)
    end

    it "user will not have rebate right when spend less than 10 transactions" do
      result = RebateHistory.check_and_update_user_rebate_right(user: test_user)
      expect(result).to eq(false)

      9.times {
        post purchase_purchase_transactions_url, params: { spend: 1 }
      }

      result = RebateHistory.check_and_update_user_rebate_right(user: test_user)
      expect(result).to eq(false)
    end
  end

  describe "cash rebate 5%" do
    it "when 100" do
      post purchase_purchase_transactions_url, params: { spend: 100 }
      transaction_id = JSON.parse(response.body)['id']
      result_rabate_point = RebateHistory
                              .where(user_id: test_user)
                              .where(purchase_transaction_id: transaction_id)
      expect(result_rabate_point[0].point).to eq(5)
    end

    it "when 250" do
      post purchase_purchase_transactions_url, params: { spend: 250 }
      transaction_id = JSON.parse(response.body)['id']
      result_rabate_point = RebateHistory
                              .where(user_id: test_user)
                              .where(purchase_transaction_id: transaction_id)
      expect(result_rabate_point[0].point).to eq(13)
    end
  end

  describe "A Free Movie Tickets" do
    it "new user spend >= $1000 within 60 days" do
      post purchase_purchase_transactions_url, params: { spend: 1000 }
      user_id = JSON.parse(response.body)['user_id']

      reward_result = Reward
                        .where(user_id: user_id)
                        .where(reward_name: "A Free Movie Tickets")
                        .present?

      expect(reward_result).to eq(true)
    end

    pending "new user spend less than $1000 within 60 days"
    pending "later 60 days"
  end

end
