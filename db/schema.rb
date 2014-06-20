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

ActiveRecord::Schema.define(version: 20140620141233) do

  create_table "activities", force: true do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "key"
    t.text     "parameters"
    t.integer  "recipient_id"
    t.string   "recipient_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "hoa_id"
  end

  add_index "activities", ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type"
  add_index "activities", ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type"
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type"

  create_table "alerts", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.string   "severity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "hoa_id"
    t.string   "progress",    default: "new"
    t.integer  "assignee_id"
  end

  add_index "alerts", ["assignee_id"], name: "index_alerts_on_assignee_id"
  add_index "alerts", ["hoa_id"], name: "index_alerts_on_hoa_id"
  add_index "alerts", ["user_id"], name: "index_alerts_on_user_id"

  create_table "announcements", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "hoa_id"
    t.integer  "user_id"
    t.string   "target_group"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "collaborations", force: true do |t|
    t.integer  "user_id"
    t.integer  "collaborable_id"
    t.string   "collaborable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "collaborations", ["collaborable_id", "collaborable_type"], name: "index_collaborations_on_collaborable_id_and_collaborable_type"
  add_index "collaborations", ["user_id"], name: "index_collaborations_on_user_id"

  create_table "comments", force: true do |t|
    t.string   "title",            limit: 50, default: ""
    t.text     "comment"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.string   "role",                        default: "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "hoa_id"
  end

  add_index "comments", ["commentable_id"], name: "index_comments_on_commentable_id"
  add_index "comments", ["commentable_type"], name: "index_comments_on_commentable_type"
  add_index "comments", ["hoa_id"], name: "index_comments_on_hoa_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "events", force: true do |t|
    t.datetime "date"
    t.string   "title"
    t.string   "location"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "hoa_id"
    t.text     "description"
  end

  add_index "events", ["hoa_id"], name: "index_events_on_hoa_id"
  add_index "events", ["user_id"], name: "index_events_on_user_id"

  create_table "hoas", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "subdomain_name"
    t.string   "subscription_type", default: "basic"
    t.datetime "subscribed_until"
    t.string   "address"
    t.string   "city"
    t.string   "postal_code"
    t.string   "kvk"
    t.string   "account_nr"
    t.string   "account_owner"
  end

  add_index "hoas", ["subdomain_name"], name: "index_hoas_on_subdomain_name", unique: true

  create_table "homepages", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "subdomain_name"
    t.integer  "hoa_id"
  end

  add_index "homepages", ["hoa_id"], name: "index_homepages_on_hoa_id"
  add_index "homepages", ["subdomain_name"], name: "index_homepages_on_subdomain_name", unique: true

  create_table "participations", force: true do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.boolean  "presence"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "participations", ["event_id"], name: "index_participations_on_event_id"
  add_index "participations", ["user_id"], name: "index_participations_on_user_id"

  create_table "payments", force: true do |t|
    t.integer  "amount"
    t.string   "description"
    t.string   "order_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "paid",        default: false
    t.string   "payment_id"
    t.integer  "hoa_id"
    t.integer  "user_id"
  end

  create_table "posts", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "hoa_id"
  end

  add_index "posts", ["hoa_id"], name: "index_posts_on_hoa_id"
  add_index "posts", ["user_id"], name: "index_posts_on_user_id"

  create_table "read_marks", force: true do |t|
    t.integer  "readable_id"
    t.integer  "user_id",                  null: false
    t.string   "readable_type", limit: 20, null: false
    t.datetime "timestamp"
  end

  add_index "read_marks", ["user_id", "readable_type", "readable_id"], name: "index_read_marks_on_user_id_and_readable_type_and_readable_id"

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], name: "index_roles_on_name"

  create_table "support_messages", force: true do |t|
    t.text     "body"
    t.integer  "user_id"
    t.integer  "hoa_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true

  create_table "tags", force: true do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: ""
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
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "hoa_id"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "invitations_count",      default: 0
    t.string   "address"
    t.string   "house_number"
    t.string   "postal_code"
    t.string   "phone_number"
    t.string   "city"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["hoa_id"], name: "index_users_on_hoa_id"
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true
  add_index "users", ["invitations_count"], name: "index_users_on_invitations_count"
  add_index "users", ["invited_by_id", "invited_by_type"], name: "index_users_on_invited_by_id_and_invited_by_type"
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "users_roles", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"

end
