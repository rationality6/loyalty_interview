class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :profile, dependent: :destroy
  has_many :purchase_transactions
  has_many :point_histories
  has_many :rewards

  def self.give_birthday_reward()
    beginning_of_month = Date.today.beginning_of_month
    beginning_of_next_month = beginning_of_month.next_month
    birthday_users = Profile.where(birthday: beginning_of_month..beginning_of_next_month)

    birthday_users.each do |birthday_user|
      Reward.create(
        user_id: birthday_user.user_id,
        reward_name: "Birth day Free Coffee reward",
      )
    end
    birthday_users
  end

end
