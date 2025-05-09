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

ActiveRecord::Schema[8.0].define(version: 2025_05_05_112442) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "combos", force: :cascade do |t|
    t.bigint "service_id", null: false
    t.integer "quantity"
    t.decimal "discount"
    t.decimal "total_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["service_id"], name: "index_combos_on_service_id"
  end

  create_table "customer_combos", force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.bigint "combo_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["combo_id"], name: "index_customer_combos_on_combo_id"
    t.index ["customer_id"], name: "index_customer_combos_on_customer_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "phone_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "redeems", force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.bigint "combo_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["combo_id"], name: "index_redeems_on_combo_id"
    t.index ["customer_id"], name: "index_redeems_on_customer_id"
  end

  create_table "services", force: :cascade do |t|
    t.string "name"
    t.decimal "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "combos", "services"
  add_foreign_key "customer_combos", "combos"
  add_foreign_key "customer_combos", "customers"
  add_foreign_key "redeems", "combos"
  add_foreign_key "redeems", "customers"
end
