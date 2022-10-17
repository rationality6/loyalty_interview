require 'rails_helper'

RSpec.describe "LoyaltyService" do
  let!(:test_user) { create(:user, :with_profile) }

  let!(:loyalty_service_instance) {
    LoyaltyService.new(user_object: :test_user)
  }

  describe "point_formula unit test" do
    it "when 10" do
      result = loyalty_service_instance.send(:point_formula, spend: 10)
      expect(result).to eq(1)
    end

    it "when 15" do
      result = loyalty_service_instance.send(:point_formula, spend: 15)
      expect(result).to eq(2)
    end

    it "when 67" do
      result = loyalty_service_instance.send(:point_formula, spend: 67)
      expect(result).to eq(7)
    end

    it "when 225 " do
      result = loyalty_service_instance.send(:point_formula, spend: 225)
      expect(result).to eq(23)
    end
  end

  describe "foreign_point_formula unit test" do
    it "when 10" do
      result = loyalty_service_instance.send(:foreign_point_formula, spend: 10)
      expect(result).to eq(2)
    end

    it "when 15" do
      result = loyalty_service_instance.send(:foreign_point_formula, spend: 15)
      expect(result).to eq(4)
    end

    it "when 67" do
      result = loyalty_service_instance.send(:foreign_point_formula, spend: 67)
      expect(result).to eq(14)
    end

    it "when 225 " do
      result = loyalty_service_instance.send(:foreign_point_formula, spend: 225)
      expect(result).to eq(46)
    end
  end

end
