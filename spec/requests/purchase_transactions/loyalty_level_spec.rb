require 'rails_helper'

RSpec.describe "LoyaltyLevel", type: :request do
  let!(:test_user) { create(:user, :with_profile) }

  describe "level test" do
    it "user promote to gold" do
      expect(test_user.profile.tier).to eq('standard')
      post purchase_purchase_transactions_url, params: { spend: 10000, test_user_id: test_user.id }
      expect(User.find(test_user.id).profile.tier).to eq('gold')
    end

    it "user promote to platinum" do
      expect(test_user.profile.tier).to eq('standard')
      post purchase_purchase_transactions_url, params: { spend: 10000, test_user_id: test_user.id }
      expect(User.find(test_user.id).profile.tier).to eq('gold')
      post purchase_purchase_transactions_url, params: { spend: 50000, test_user_id: test_user.id }
      expect(User.find(test_user.id).profile.tier).to eq('platinum')
    end

    it "when user got promoted to gold got airport reward" do
      expect(test_user.profile.tier).to eq('standard')
      post purchase_purchase_transactions_url, params: { spend: 10000, test_user_id: test_user.id }
      the_user = User.find(test_user.id)
      expect(the_user.profile.tier).to eq('gold')
      reward_present = Reward.where({ user_id: the_user, reward_name: "4x Airport Lounge Access Reward" }).present?
      expect(reward_present).to eq(true)
    end

  end

end
