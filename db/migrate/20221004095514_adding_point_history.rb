class AddingPointHistory < ActiveRecord::Migration[6.1]
  def change
    create_table :point_history do |t|
      t.references :user
      t.references :transaction
      t.bigint :point_earn, default: 0, comment: "point earn"
      t.datetime :expired, comment: "expired after 1 year"
      t.timestamps
    end
  end
end
