# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_10_04_104137) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "point_histories", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "purchase_transaction_id"
    t.bigint "point_earn", default: 0, comment: "point earn"
    t.datetime "expired", comment: "expired after 1 year"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["purchase_transaction_id"], name: "index_point_histories_on_purchase_transaction_id"
    t.index ["user_id"], name: "index_point_histories_on_user_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.bigint "user_id"
    t.string "name", default: "", comment: "user name"
    t.datetime "birthday", comment: "user birthday"
    t.string "tier", default: "standard", comment: "user tier ['standard', 'gold', 'platinum' ]"
    t.bigint "point_total", default: 0, comment: "user point total for cache"
    t.boolean "cash_rebate_qualified", default: false, comment: "user rebate qualified"
    t.bigint "rebate", default: 0, comment: "user rebate total for cache"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "purchase_transactions", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "spend", default: 0, comment: "money spending user transaction"
    t.boolean "from_foreign_country", default: false, comment: "transaction from foreign check"
    t.boolean "rewarded", default: false, comment: "rewarded check"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_purchase_transactions_on_user_id"
  end

  create_table "rebate_histories", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "purchase_transaction_id"
    t.bigint "point", default: 0, comment: "rebate user earn"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["purchase_transaction_id"], name: "index_rebate_histories_on_purchase_transaction_id"
    t.index ["user_id"], name: "index_rebate_histories_on_user_id"
  end

  create_table "rewards", force: :cascade do |t|
    t.bigint "user_id"
    t.string "reward_name", default: "", comment: "reward name"
    t.datetime "when_used", comment: "when_used check"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_rewards_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
