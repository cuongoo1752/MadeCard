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

ActiveRecord::Schema.define(version: 2024_05_08_174859) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cards", force: :cascade do |t|
    t.boolean "is_public"
    t.integer "status"
    t.bigint "user_id", null: false
    t.integer "order"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.integer "fix_picture_id"
    t.index ["user_id"], name: "index_cards_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.string "content"
    t.integer "status"
    t.bigint "user_id", null: false
    t.integer "order"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["event_id"], name: "index_categories_on_event_id"
    t.index ["user_id"], name: "index_categories_on_user_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "content"
    t.integer "status"
    t.bigint "user_id", null: false
    t.integer "order"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "fake_texts", force: :cascade do |t|
    t.text "content"
    t.integer "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "fix_fonts", force: :cascade do |t|
    t.string "title"
    t.bigint "user_id", null: false
    t.string "font"
    t.integer "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_fix_fonts_on_user_id"
  end

  create_table "fix_pictures", force: :cascade do |t|
    t.string "title"
    t.bigint "user_id", null: false
    t.string "picture"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status"
    t.index ["user_id"], name: "index_fix_pictures_on_user_id"
  end

  create_table "images", force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.integer "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "width"
    t.integer "height"
    t.integer "top"
    t.integer "left"
  end

  create_table "layers", force: :cascade do |t|
    t.string "name"
    t.integer "order"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "layers_on_cards", force: :cascade do |t|
    t.string "name"
    t.bigint "card_id", null: false
    t.integer "layer_id"
    t.string "layer_type"
    t.integer "status"
    t.integer "order"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["card_id"], name: "index_layers_on_cards_on_card_id"
    t.index ["user_id"], name: "index_layers_on_cards_on_user_id"
  end

  create_table "texts", force: :cascade do |t|
    t.text "content"
    t.boolean "is_long"
    t.string "font"
    t.string "color"
    t.integer "size"
    t.string "text_align"
    t.string "vertical"
    t.string "text_type"
    t.integer "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "width"
    t.integer "height"
    t.integer "top"
    t.integer "left"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password"
    t.string "role"
    t.integer "status"
    t.string "order"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "wishes", force: :cascade do |t|
    t.bigint "category_id", null: false
    t.text "content"
    t.integer "status"
    t.bigint "user_id", null: false
    t.integer "order"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_wishes_on_category_id"
    t.index ["user_id"], name: "index_wishes_on_user_id"
  end

  add_foreign_key "cards", "users"
  add_foreign_key "categories", "events"
  add_foreign_key "categories", "users"
  add_foreign_key "events", "users"
  add_foreign_key "fix_fonts", "users"
  add_foreign_key "fix_pictures", "users"
  add_foreign_key "layers_on_cards", "cards"
  add_foreign_key "layers_on_cards", "users"
  add_foreign_key "wishes", "categories"
  add_foreign_key "wishes", "users"
end
