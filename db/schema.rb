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

ActiveRecord::Schema.define(:version => 20121009140441) do

  create_table "books", :force => true do |t|
    t.string   "name"
    t.string   "permalink"
    t.text     "description"
    t.text     "notes"
    t.datetime "published_at"
    t.integer  "position"
    t.integer  "comments_count"
    t.boolean  "legacy"
    t.text     "file_sizes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
    t.string   "audio"
    t.integer  "seconds"
    t.boolean  "asciibooks"
    t.string   "image_link"
    t.integer  "language_id"
    t.string   "narrator"
  end

  create_table "comments", :force => true do |t|
    t.integer  "book_id"
    t.text     "content"
    t.string   "f_name"
    t.string   "l_name"
    t.string   "email"
    t.string   "user_id"
    t.string   "referrer"
    t.string   "user_ip"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ancestry"
    t.string   "site_url"
    t.string   "user_agent"
  end

  add_index "comments", ["ancestry"], :name => "index_comments_on_ancestry"

  create_table "feedback_messages", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "languages", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "book_id"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "terminologies", :force => true do |t|
    t.integer  "book_id"
    t.integer  "language_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_sessions", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "email_on_reply"
    t.string   "site_url"
    t.string   "role"
  end

end
