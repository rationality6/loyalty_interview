require 'rails_helper'

RSpec.describe "LoyaltyLevel", type: :request do
  let!(:test_user) { create(:user, :skip_validate) }

  describe "level test" do
    pending "user promote to gold"

    pending "user promote to platinum"
  end

end
