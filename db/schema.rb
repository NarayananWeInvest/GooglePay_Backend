# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_12_13_095340) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bank_accounts", force: :cascade do |t|
    t.string "acc_no", null: false
    t.string "ifsc", null: false
    t.string "balance", default: "0"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_bank_accounts_on_user_id"
  end

  create_table "rules", force: :cascade do |t|
    t.string "period"
    t.bigint "limit"
    t.bigint "min_range"
    t.bigint "max_range"
    t.string "type_user"
    t.bigint "scratch_card_min"
    t.bigint "scratch_card_max"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "scratch_cards", force: :cascade do |t|
    t.bigint "user_id"
    t.string "amount_won"
    t.bigint "trans_id_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["trans_id_id"], name: "index_scratch_cards_on_trans_id_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.bigint "t_user1_id"
    t.bigint "t_user2_id"
    t.string "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["t_user1_id"], name: "index_transactions_on_t_user1_id"
    t.index ["t_user2_id"], name: "index_transactions_on_t_user2_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "phone", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
