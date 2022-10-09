class UserProfileRewardDataJson < ActiveRecord::Migration[6.1]
  def up
    add_column :profiles, :reward_info, :jsonb, default: {}, comment: 'for save user reward infos'
  end

  def down
    remove_column :profiles, :reward_info
  end
end
