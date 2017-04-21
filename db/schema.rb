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

ActiveRecord::Schema.define(version: 20170421095021) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: :cascade do |t|
    t.string   "title"
    t.text     "details"
    t.integer  "location_id"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "picture"
    t.integer  "quality"
    t.string   "rate"
    t.boolean  "gratis"
    t.integer  "stockitem_id"
    t.index ["location_id"], name: "index_articles_on_location_id", using: :btree
    t.index ["stockitem_id"], name: "index_articles_on_stockitem_id", using: :btree
    t.index ["user_id"], name: "index_articles_on_user_id", using: :btree
  end

  create_table "houses", force: :cascade do |t|
    t.string   "street"
    t.string   "city"
    t.string   "postcode"
    t.string   "country"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "number"
  end

  create_table "locations", force: :cascade do |t|
    t.string   "street"
    t.string   "postcode"
    t.string   "city"
    t.string   "country"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "house_id"
    t.string   "number"
    t.index ["house_id"], name: "index_locations_on_house_id", using: :btree
    t.index ["user_id"], name: "index_locations_on_user_id", using: :btree
  end

  create_table "messages", force: :cascade do |t|
    t.string   "text"
    t.integer  "sender_id"
    t.integer  "receiver_id"
    t.boolean  "with_name"
    t.boolean  "with_phoneno"
    t.boolean  "with_email"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "subject"
    t.string   "html"
    t.index ["receiver_id"], name: "index_messages_on_receiver_id", using: :btree
    t.index ["sender_id"], name: "index_messages_on_sender_id", using: :btree
  end

  create_table "searches", force: :cascade do |t|
    t.string   "pattern"
    t.string   "address"
    t.float    "radius"
    t.boolean  "use_location"
    t.integer  "location_id"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "transport"
  end

  create_table "stockitem_selections", force: :cascade do |t|
  end

  create_table "stockitem_selections_stockitems", id: false, force: :cascade do |t|
    t.integer "stockitem_selection_id"
    t.integer "stockitem_id"
    t.index ["stockitem_id"], name: "index_stockitem_selections_stockitems_on_stockitem_id", using: :btree
    t.index ["stockitem_selection_id"], name: "index_stockitem_selections_stockitems_on_stockitem_selection_id", using: :btree
  end

  create_table "stockitems", force: :cascade do |t|
    t.string   "title_de"
    t.text     "details_hint"
    t.string   "picture"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "room"
    t.string   "rate"
    t.string   "title_en"
  end

  create_table "template_selections", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "template_selections_templates", id: false, force: :cascade do |t|
    t.integer "template_selection_id"
    t.integer "template_id"
    t.index ["template_id"], name: "index_template_selections_templates_on_template_id", using: :btree
    t.index ["template_selection_id"], name: "index_template_selections_templates_on_template_selection_id", using: :btree
  end

  create_table "user_article_requests", force: :cascade do |t|
    t.string   "text"
    t.integer  "article_id"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.boolean  "with_phoneno"
    t.boolean  "with_email"
    t.boolean  "with_name"
    t.index ["article_id"], name: "index_user_article_requests_on_article_id", using: :btree
    t.index ["user_id"], name: "index_user_article_requests_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "role"
    t.string   "nickname"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "phoneno"
    t.boolean  "showemail"
    t.boolean  "showphone"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.boolean  "showname"
    t.string   "private_uuid"
    t.string   "public_uuid"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["nickname"], name: "index_users_on_nickname", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "articles", "locations"
  add_foreign_key "articles", "stockitems"
  add_foreign_key "articles", "users"
  add_foreign_key "locations", "users"
  add_foreign_key "searches", "locations"
  add_foreign_key "user_article_requests", "articles"
end
