require 'rails_helper'

RSpec.describe "User", type: :model do
  describe "birthday coffee reward" do

    let!(:test_user) { create(:user, :skip_validate, :test_email, :with_profile) }

    it "birthday" do
      # after batch
      Reward.give_birthday_reward()
      birth_coffee_reward = Reward
                              .where(user_id: test_user.id)
                              .where(reward_name: "Birth day Free Coffee reward")

      expect(birth_coffee_reward.present?).to eq(true)
    end

    let!(:past_birthday_user) { create(:user, :skip_validate, :test_email01, :with_past_birth_profile) }

    it "no" do
      Reward.give_birthday_reward()
      birth_coffee_reward = Reward
                              .where(user_id: past_birthday_user.id)
                              .where(reward_name: "Birth day Free Coffee reward")

      expect(birth_coffee_reward.present?).to eq(false)
    end
  end

end
