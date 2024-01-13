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

ActiveRecord::Schema[7.0].define(version: 2024_01_13_151906) do
  create_table "cards", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.text "front"
    t.text "back"
    t.bigint "user_id", null: false
    t.bigint "deck_id", null: false
    t.integer "rating"
    t.datetime "next_review"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "stability", default: 0
    t.integer "difficulty", default: 0
    t.integer "reps", default: 0
    t.integer "state", default: 0
    t.string "dues_predict"
    t.datetime "last_review"
    t.index ["deck_id"], name: "index_cards_on_deck_id"
    t.index ["user_id"], name: "index_cards_on_user_id"
  end

  create_table "decks", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "parent_id"
    t.bigint "user_id", null: false
    t.index ["name"], name: "index_decks_on_name", unique: true
    t.index ["parent_id"], name: "index_decks_on_parent_id"
    t.index ["user_id"], name: "index_decks_on_user_id"
  end

  create_table "review_histories", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "card_id", null: false
    t.integer "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["card_id"], name: "index_review_histories_on_card_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "jti", null: false
    t.string "nickname", default: "", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["jti"], name: "index_users_on_jti", unique: true
    t.index ["nickname"], name: "index_users_on_nickname", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "cards", "decks"
  add_foreign_key "cards", "users"
  add_foreign_key "decks", "decks", column: "parent_id"
  add_foreign_key "decks", "users"
  add_foreign_key "review_histories", "cards"
end
