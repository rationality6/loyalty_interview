require 'rails_helper'

RSpec.describe "LoyaltyService" do
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

  let!(:loyalty_service_instance) {
    LoyaltyService.new(user_object: :test_user)
  }

  describe "point_formula unit test" do
    it "when 10" do
      result = loyalty_service_instance.send(:point_formula, 10)
      expect(result).to eq(1)
    end

    it "when 15" do
      result = loyalty_service_instance.send(:point_formula, 15)
      expect(result).to eq(2)
    end

    it "when 67" do
      result = loyalty_service_instance.send(:point_formula, 67)
      expect(result).to eq(7)
    end

    it "when 225 " do
      result = loyalty_service_instance.send(:point_formula, 225)
      expect(result).to eq(23)
    end
  end


end
