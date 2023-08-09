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

ActiveRecord::Schema[7.0].define(version: 2023_07_30_222613) do
  create_table "brokers", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "password_digest"
    t.boolean "isBroker", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "buyer_foams", force: :cascade do |t|
    t.string "supplier_name"
    t.string "country"
    t.string "boxMark"
    t.string "variety"
    t.string "s1"
    t.string "stems"
    t.integer "quantity"
    t.string "boxtype"
    t.float "cost"
    t.float "amount"
    t.float "price"
    t.float "total"
    t.integer "duty"
    t.string "assigned_to"
    t.integer "buyer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "buyers", force: :cascade do |t|
    t.string "buyer_name"
    t.string "email"
    t.string "password_digest"
    t.boolean "isBuyer", default: true
    t.integer "broker_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "suppliers", force: :cascade do |t|
    t.string "supplier_name"
    t.string "email"
    t.string "password_digest"
    t.boolean "isSupplier", default: true
    t.integer "broker_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "supplies", force: :cascade do |t|
    t.string "supplier_credentials"
    t.string "country"
    t.string "boxmark"
    t.string "type_flower"
    t.string "variety"
    t.string "s1"
    t.integer "quantity"
    t.string "boxtype"
    t.string "stems"
    t.float "cost"
    t.float "amount"
    t.string "total"
    t.string "assign_to"
    t.integer "supplier_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
