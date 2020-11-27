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

ActiveRecord::Schema.define(version: 2020_11_26_145107) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.jsonb "labels", default: [], array: true
    t.jsonb "regions", default: [], array: true
<<<<<<< HEAD
    t.boolean "withdrawal"
=======
>>>>>>> feature/RDF-265_map_with_near_farms
    t.index ["user_id"], name: "index_farms_on_user_id"
  end

  create_table "products", force: :cascade do |t|
    t.bigint "farm_id", null: false
    t.string "name"
    t.bigint "category_id", null: false
    t.string "photo"
    t.text "description"
    t.string "ingredients"
    t.string "label"
    t.integer "unit_price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "kg_price"
    t.string "unit"
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
    t.string "name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "farm_categories", "categories"
  add_foreign_key "farm_categories", "farms"
  add_foreign_key "farms", "users"
  add_foreign_key "products", "categories"
  add_foreign_key "products", "farms"
end
