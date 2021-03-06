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

ActiveRecord::Schema.define(version: 2018_12_13_035051) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "blocks", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "blockable_id"
    t.string "blockable_type"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["blockable_type", "blockable_id"], name: "index_blocks_on_blockable_type_and_blockable_id"
  end

  create_table "chat_rooms", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "to_user_id"
    t.integer "unread_count"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "facebook_auths", force: :cascade do |t|
    t.bigint "user_id"
    t.string "access_token"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "foot_prints", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "to_user_id"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "chat_room_id"
    t.string "message_type", default: "Text", null: false
    t.string "text"
    t.string "attachment_url"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "read_flag", default: false, null: false
  end

  create_table "reports", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "reportable_id"
    t.string "reportable_type"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reportable_type", "reportable_id"], name: "index_reports_on_reportable_type_and_reportable_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.integer "gender"
    t.integer "height"
    t.integer "figure"
    t.integer "work"
    t.integer "income"
    t.integer "debt"
    t.integer "hobby"
    t.string "body"
    t.datetime "birthday"
    t.integer "divorced_number"
    t.integer "children"
    t.datetime "last_merried_start_time"
    t.datetime "last_merried_last_time"
    t.integer "remarried_desired_time"
    t.string "divorced_reason"
    t.string "what_learned_from_divorce"
    t.string "adress"
    t.integer "age"
    t.integer "final_education"
    t.string "message_for_opponent"
    t.boolean "is_facebook_connected", default: false
    t.datetime "last_login_at"
    t.string "authentication_token"
    t.string "icon"
    t.boolean "is_sms_verified", default: false
    t.string "firebase_token"
    t.boolean "is_purchased", default: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
