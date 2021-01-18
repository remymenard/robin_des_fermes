# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_01_18_085947) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "delivery_choices", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.bigint "farm_id", null: false
    t.boolean "takeaway_at_farm"
    t.boolean "standard_shipping"
    t.boolean "express_shipping"
    t.index ["farm_id"], name: "index_delivery_choices_on_farm_id"
    t.index ["order_id"], name: "index_delivery_choices_on_order_id"
  end

  create_table "farm_categories", force: :cascade do |t|
    t.bigint "farm_id", null: false
    t.bigint "category_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_farm_categories_on_category_id"
    t.index ["farm_id"], name: "index_farm_categories_on_farm_id"
  end

  create_table "farms", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id", null: false
    t.string "photo"
    t.string "address"
    t.float "latitude"
    t.float "longitude"
    t.string "opening_time"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "regions", default: [], array: true
    t.boolean "accepts_take_away", default: false
    t.string "zip_code"
    t.string "city"
    t.string "country"
    t.integer "farmer_number"
    t.string "iban"
    t.text "long_description"
    t.boolean "accept_delivery", default: false
    t.integer "delivery_delay"
    t.boolean "active", default: false
    t.text "labels", array: true
    t.index ["user_id"], name: "index_farms_on_user_id"
  end

  create_table "opening_hours", force: :cascade do |t|
    t.bigint "farm_id", null: false
    t.integer "day"
    t.time "closes"
    t.time "opens"
    t.datetime "valid_from"
    t.datetime "valid_through"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["farm_id"], name: "index_opening_hours_on_farm_id"
  end

  create_table "order_line_items", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.bigint "product_id", null: false
    t.integer "quantity", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_line_items_on_order_id"
    t.index ["product_id"], name: "index_order_line_items_on_product_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "price_cents", default: 0, null: false
    t.string "price_currency", default: "CHF", null: false
    t.string "status", default: "waiting"
    t.string "transaction_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "buyer_id"
    t.index ["buyer_id"], name: "index_orders_on_buyer_id"
  end

  create_table "products", force: :cascade do |t|
    t.bigint "farm_id", null: false
    t.string "name"
    t.bigint "category_id", null: false
    t.string "photo"
    t.text "description"
    t.text "ingredients"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "unit"
    t.text "label", default: [], array: true
    t.boolean "available"
    t.boolean "fresh"
    t.integer "price_per_unit_cents", default: 0, null: false
    t.string "price_per_unit_currency", default: "CHF", null: false
    t.integer "price_cents", default: 0, null: false
    t.string "price_currency", default: "CHF", null: false
    t.string "subtitle"
    t.string "minimum_weight"
    t.boolean "display_minimum_weight", default: false
    t.string "conditioning"
    t.string "total_weight"
    t.date "preorder"
    t.boolean "active", default: false
    t.index ["category_id"], name: "index_products_on_category_id"
    t.index ["farm_id"], name: "index_products_on_farm_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "zip_code"
    t.string "first_name"
    t.string "last_name"
    t.string "address_line_1"
    t.string "title"
    t.string "city"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.boolean "wants_to_subscribe_mailing_list"
    t.string "address_line_2"
    t.boolean "admin"
    t.string "number_phone"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "delivery_choices", "farms"
  add_foreign_key "delivery_choices", "orders"
  add_foreign_key "farm_categories", "categories"
  add_foreign_key "farm_categories", "farms"
  add_foreign_key "farms", "users"
  add_foreign_key "opening_hours", "farms"
  add_foreign_key "order_line_items", "orders"
  add_foreign_key "order_line_items", "products"
  add_foreign_key "orders", "users", column: "buyer_id"
  add_foreign_key "products", "categories"
  add_foreign_key "products", "farms"
end
