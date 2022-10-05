require 'rails_helper'

RSpec.describe "Transactions", type: :request do
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

  context "10% point" do
    it "when no params spend" do
      expect {
        post '/api/v1/transactions/purchase', params: {}
      }.to raise_error("no spend params")
    end

    it "status check" do
      post '/api/v1/transactions/purchase', params: { spend: 60 }
      expect(response.status).to(eq(200))
    end

    it "user save" do
      binding.pry
      expect('a').to(eq('a'))
    end

  end
end
