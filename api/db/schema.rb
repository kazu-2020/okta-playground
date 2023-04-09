ActiveRecord::Schema[7.0].define(version: 2023_04_03_141442) do
  enable_extension "plpgsql"

  create_table "users", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "email", null: false
    t.string "okta_user_name", null: false, comment: "Okta上で一意なユーザー名"
    t.boolean "active", default: false, null: false, comment: "Okta上で有効かどうか"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["okta_user_name"], name: "index_users_on_okta_user_name", unique: true
  end

end
