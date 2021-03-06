# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150628055629) do

  create_table "address_entries", force: :cascade do |t|
    t.float    "lat"
    t.float    "long"
    t.string   "street1"
    t.string   "street2"
    t.string   "city"
    t.string   "state"
    t.integer  "zip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "api_actions", force: :cascade do |t|
    t.string  "name"
    t.integer "role_id"
  end

  create_table "appointment_requests", force: :cascade do |t|
    t.datetime "request_time"
    t.integer  "client_id"
    t.integer  "volunteer_id"
    t.text     "appointment_notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "client_flags", force: :cascade do |t|
    t.string  "flag_value"
    t.integer "yes_no_flag_id"
    t.integer "client_id"
    t.integer "flag_config_id"
  end

  create_table "clients", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "age"
    t.integer  "mr_number"
    t.integer  "family_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "case_contact_id"
    t.integer  "child_id"
    t.integer  "parent_id"
    t.integer  "priority"
  end

  create_table "contact_entries", force: :cascade do |t|
    t.string   "type"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "client_id"
  end

  create_table "families", force: :cascade do |t|
    t.integer  "size"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "field_notes", force: :cascade do |t|
    t.text     "entry"
    t.integer  "author_id"
    t.integer  "client_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "flag_configs", force: :cascade do |t|
    t.string "display_value"
    t.string "key"
  end

  create_table "form_answers", force: :cascade do |t|
    t.text    "answer_value"
    t.integer "question_id"
    t.string  "question_type"
    t.integer "form_entry_id"
  end

  create_table "form_cross_references", force: :cascade do |t|
    t.integer  "form_entry_id"
    t.string   "cross_reference_type"
    t.integer  "cross_reference_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "form_entries", force: :cascade do |t|
    t.integer  "form_structure_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "form_author_id"
  end

  create_table "form_structure_entries", force: :cascade do |t|
    t.integer  "question_id"
    t.integer  "form_structure_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "question_type"
    t.integer  "sort_order"
  end

  create_table "form_structures", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "form_name"
    t.integer  "author_id"
  end

  create_table "form_tracking_ids", force: :cascade do |t|
    t.string   "tracking_id"
    t.integer  "client_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "free_text_questions", force: :cascade do |t|
    t.string "display_value"
    t.string "key"
  end

  create_table "multiple_choice_questions", force: :cascade do |t|
    t.string   "display_value"
    t.text     "choices"
    t.boolean  "is_boolean"
    t.boolean  "allows_multiple"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "key"
  end

  create_table "navbar_entries", force: :cascade do |t|
    t.string   "title"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "oauth_access_grants", force: :cascade do |t|
    t.integer  "resource_owner_id", null: false
    t.integer  "application_id",    null: false
    t.string   "token",             null: false
    t.integer  "expires_in",        null: false
    t.text     "redirect_uri",      null: false
    t.datetime "created_at",        null: false
    t.datetime "revoked_at"
    t.string   "scopes"
  end

  add_index "oauth_access_grants", ["token"], name: "index_oauth_access_grants_on_token", unique: true

  create_table "oauth_access_tokens", force: :cascade do |t|
    t.integer  "resource_owner_id"
    t.integer  "application_id"
    t.string   "token",             null: false
    t.string   "refresh_token"
    t.integer  "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at",        null: false
    t.string   "scopes"
  end

  add_index "oauth_access_tokens", ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true
  add_index "oauth_access_tokens", ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id"
  add_index "oauth_access_tokens", ["token"], name: "index_oauth_access_tokens_on_token", unique: true

  create_table "oauth_applications", force: :cascade do |t|
    t.string   "name",         null: false
    t.string   "uid",          null: false
    t.string   "secret",       null: false
    t.text     "redirect_uri", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "oauth_applications", ["uid"], name: "index_oauth_applications_on_uid", unique: true

  create_table "organizations", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.text     "urls"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "org_key"
  end

  create_table "parent_child_relationships", force: :cascade do |t|
    t.integer  "child_id"
    t.integer  "parent_id"
    t.integer  "family_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "service_locations", force: :cascade do |t|
    t.string   "name"
    t.integer  "address_entry_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "skill_claims", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "worker_skill_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "theme_components", force: :cascade do |t|
    t.string  "theme_config"
    t.integer "organization_id"
    t.boolean "is_active"
  end

  create_table "user_actions", force: :cascade do |t|
    t.string   "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin"
    t.boolean  "speaks_spanish"
    t.integer  "role_id"
    t.integer  "manager_id"
    t.string   "contact_email"
    t.string   "full_name"
    t.integer  "employer_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "visits", force: :cascade do |t|
    t.datetime "visit_date"
    t.integer  "client_id"
    t.integer  "service_location_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "worker_skills", force: :cascade do |t|
    t.string   "skill_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "yes_no_flags", force: :cascade do |t|
    t.string   "display_value"
    t.string   "key"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
