require 'rails_helper'

RSpec.describe "User Model", type: :model do
  let!(:test_user) {
    user = User.new(email: "test_user")
    user.save(validate: false)
    user
  }

  let!(:user_profile) {
    profile = Profile.new({
                            user_id: test_user.id,
                            birthday: Time.now
                          })
    profile.save()
    profile
  }

  let!(:past_birthday_user) {
    user = User.new(email: "past_birthday_user")
    user.save(validate: false)
    user
  }

  let!(:past_birthday_user_profile) {
    profile = Profile.new({
                            user_id: past_birthday_user.id,
                            birthday: (Time.now) - 1.months
                          })
    profile.save()
    profile
  }

  describe "birthday coffee reward" do
    it "birthday" do
      # after batch
      Reward.give_birthday_reward()

      birth_coffee_reward = Reward
                              .where(user_id: test_user.id)
                              .where(reward_name: "Birth day Free Coffee reward")

      expect(birth_coffee_reward.present?).to eq(true)
    end

    it "no" do
      Reward.give_birthday_reward()
      birth_coffee_reward = Reward
                              .where(user_id: past_birthday_user.id)
                              .where(reward_name: "Birth day Free Coffee reward")

      expect(birth_coffee_reward.present?).to eq(false)
    end
  end

end
