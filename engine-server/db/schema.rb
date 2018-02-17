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

ActiveRecord::Schema.define(version: 2018_02_17_174025) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "matches", force: :cascade do |t|
    t.string "response_type"
    t.bigint "sequence"
    t.string "product_name"
    t.decimal "price"
    t.decimal "open_24h"
    t.decimal "volume_24h"
    t.decimal "low_24h"
    t.decimal "high_24h"
    t.decimal "volume_30d"
    t.decimal "best_bid"
    t.decimal "best_ask"
    t.string "side"
    t.datetime "time"
    t.bigint "trade_id"
    t.decimal "last_size"
    t.bigint "product_id"
    t.string "exchange_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exchange_name"], name: "index_matches_on_exchange_name"
    t.index ["product_id"], name: "index_matches_on_product_id"
    t.index ["product_name"], name: "index_matches_on_product_name"
  end

  create_table "products", force: :cascade do |t|
    t.string "product_name"
    t.string "base_currency"
    t.string "quote_currency"
    t.decimal "base_min_size"
    t.bigint "base_max_size"
    t.decimal "quote_increment"
    t.string "display_name"
    t.string "status"
    t.boolean "margin_enabled"
    t.string "status_message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_name"], name: "index_products_on_product_name"
  end

  add_foreign_key "matches", "products"
end
