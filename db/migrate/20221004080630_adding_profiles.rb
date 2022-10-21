class AddingProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :profiles do |t|
      t.references :user
      t.string :name, default: '', comment: 'user name'
      t.datetime :birthday, comment: 'user birthday'
      t.string :tier, default: 'standard', comment: "user tier ['standard', 'gold', 'platinum' ]"
      t.bigint :point_total, default: 0, comment: 'user point total for cache'
      t.boolean :cash_rebate_qualified, default: false, comment: 'user rebate qualified'
      t.bigint :rebate, default: 0, comment: 'user rebate total for cache'
      t.timestamps
    end
  end
end
