class AddingRewardsMigration < ActiveRecord::Migration[6.1]
  def change
    create_table :rewards do |t|
      t.references :user
      t.string :reward_name, default: "", comment: "reward name"
      t.timedate :used, default: false, comment: "used check"
      t.timestamps
    end
  end
end

