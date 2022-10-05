require 'rails_helper'

RSpec.describe "Transactions", type: :request do
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
  end
end
