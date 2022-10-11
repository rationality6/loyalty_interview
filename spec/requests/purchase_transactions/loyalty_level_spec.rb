require 'rails_helper'

RSpec.describe "LoyaltyLevel", type: :request do
  let!(:test_user) { create(:user, :skip_validate) }
  let!(:test_user_profile) { Profile.create({ user_id: test_user.id }) }

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
  end

end
