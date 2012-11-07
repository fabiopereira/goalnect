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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121107150602) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "token"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "charities", :force => true do |t|
    t.string   "charity_name"
    t.text     "description"
    t.string   "contact_name"
    t.string   "email"
    t.string   "phone"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.boolean  "active"
    t.string   "logo"
    t.string   "cnpj"
    t.string   "nickname"
    t.string   "image"
    t.string   "website"
    t.string   "pagseguro_authenticity_token"
    t.string   "pagseguro_email"
  end

  create_table "charity_updates", :force => true do |t|
    t.integer  "charity_id"
    t.text     "message"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "countries", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "goal_donation_payment_notifications", :force => true do |t|
    t.integer  "goal_donation_id"
    t.string   "transaction_id"
    t.decimal  "price"
    t.decimal  "fees"
    t.string   "donor_name"
    t.string   "donor_email"
    t.string   "payment_method"
    t.datetime "processed_at"
    t.string   "currency"
    t.string   "payment_channel"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "stage_id"
  end

  create_table "goal_donation_point_transactions", :force => true do |t|
    t.integer  "goal_donation_id"
    t.integer  "goal_id"
    t.integer  "user_id"
    t.integer  "point_amount"
    t.boolean  "active"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "goal_donations", :force => true do |t|
    t.text     "message"
    t.integer  "goal_id"
    t.integer  "user_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "donor_name"
    t.boolean  "processed"
    t.integer  "amount"
    t.decimal  "goalnect_fee"
    t.decimal  "pagseguro_fee"
    t.integer  "charity_id"
    t.integer  "current_stage_id"
  end

  create_table "goal_feedbacks", :force => true do |t|
    t.text     "message"
    t.integer  "goal_id"
    t.integer  "user_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "goal_stage_id"
  end

  create_table "goal_supports", :force => true do |t|
    t.boolean  "i_support"
    t.integer  "goal_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "goal_templates", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.boolean  "active"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "locale"
  end

  create_table "goals", :force => true do |t|
    t.integer  "owner_id"
    t.text     "description"
    t.string   "title"
    t.date     "due_on"
    t.integer  "achiever_id"
    t.integer  "goal_stage_id"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.datetime "goal_stage_changed_at"
    t.integer  "charity_id"
    t.decimal  "target_amount"
    t.integer  "goal_template_id"
  end

  add_index "goals", ["achiever_id"], :name => "index_goals_on_achiever_id"
  add_index "goals", ["owner_id"], :name => "index_goals_on_owner_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "username",               :default => "", :null => false
    t.string   "screen_name",            :default => "", :null => false
    t.date     "dob"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "image"
    t.text     "about_me"
    t.boolean  "admin"
    t.integer  "country_id",             :default => 1
    t.integer  "charity_id"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["username"], :name => "index_users_on_url", :unique => true

end
