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

ActiveRecord::Schema.define(version: 20200405103719) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", id: :serial, force: :cascade do |t|
    t.string "title"
    t.text "details"
    t.integer "location_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "rate"
    t.integer "stockitem_id"
    t.string "lent_description"
    t.index ["location_id"], name: "index_articles_on_location_id"
    t.index ["stockitem_id"], name: "index_articles_on_stockitem_id"
  end

  create_table "categories", id: :serial, force: :cascade do |t|
    t.string "name_de"
    t.string "name_en"
  end

  create_table "houses", id: :serial, force: :cascade do |t|
    t.string "country"
    t.float "latitude"
    t.float "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "address"
  end

  create_table "locations", id: :serial, force: :cascade do |t|
    t.string "country"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "latitude"
    t.float "longitude"
    t.integer "house_id"
    t.string "address"
    t.index ["house_id"], name: "index_locations_on_house_id"
    t.index ["user_id"], name: "index_locations_on_user_id", unique: true
  end

  create_table "messages", id: :serial, force: :cascade do |t|
    t.string "text"
    t.integer "sender_id"
    t.integer "receiver_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "subject"
    t.string "html"
    t.index ["receiver_id"], name: "index_messages_on_receiver_id"
    t.index ["sender_id"], name: "index_messages_on_sender_id"
  end

  create_table "searches", id: :serial, force: :cascade do |t|
    t.string "pattern"
    t.string "address"
    t.boolean "use_location"
    t.integer "location_id"
    t.float "latitude"
    t.float "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "transport"
  end

  create_table "stockitem_selections", id: :serial, force: :cascade do |t|
  end

  create_table "stockitem_selections_stockitems", id: false, force: :cascade do |t|
    t.integer "stockitem_selection_id"
    t.integer "stockitem_id"
    t.index ["stockitem_id"], name: "index_stockitem_selections_stockitems_on_stockitem_id"
    t.index ["stockitem_selection_id"], name: "index_stockitem_selections_stockitems_on_stockitem_selection_id"
  end

  create_table "stockitems", id: :serial, force: :cascade do |t|
    t.string "title_de"
    t.text "details_hint_de"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title_en"
    t.string "details_hint_en"
    t.integer "category_id"
    t.index ["category_id"], name: "index_stockitems_on_category_id"
  end

  create_table "user_article_requests", id: :serial, force: :cascade do |t|
    t.string "text"
    t.integer "article_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["article_id"], name: "index_user_article_requests_on_article_id"
    t.index ["user_id"], name: "index_user_article_requests_on_user_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "nickname"
    t.string "phoneno"
    t.boolean "showemail"
    t.boolean "showphone"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "private_uuid"
    t.string "public_uuid"
    t.string "aboutme"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["nickname"], name: "index_users_on_nickname", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "articles", "locations"
  add_foreign_key "articles", "stockitems"
  add_foreign_key "locations", "users"
  add_foreign_key "searches", "locations"
  add_foreign_key "stockitems", "categories"
  add_foreign_key "user_article_requests", "articles"
end
