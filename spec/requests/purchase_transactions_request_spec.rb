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
      post '/api/v1/purchase_transactions/purchase', params: {}
    }.to raise_error("no spend params")
  end

  it "status check" do
    post '/api/v1/purchase_transactions/purchase', params: { spend: 60 }
    expect(response.status).to(eq(200))
  end

  # it "10% point" do
  #   expect
  # end
  #
  # it "when from foreign country, point * 2 " do
  #
  # end
end
