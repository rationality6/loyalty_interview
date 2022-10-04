class AddingRebateHistory < ActiveRecord::Migration[6.1]
  def change
    create_table :rebate_history do |t|
      t.references :user
      t.references :transaction
      t.bigint :point, default: 0, comment: "rebate user earn"
      t.timestamps
    end
  end
end