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

  pending "10% point"
  pending "from_foreign * 2"

end
