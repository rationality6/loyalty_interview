class AddingTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :purchase_transactions do |t|
      t.references :user
      t.bigint :spend, default: 0, comment: "money spending user transaction"
      t.boolean :from_foreign_country, default: false, comment: "transaction from foreign check"
      t.boolean :rewarded, default: false, comment: "rewarded check"
      t.timestamps
    end
  end
end
