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

ActiveRecord::Schema.define(:version => 20110906010101) do

  create_table "admin_settings", :force => true do |t|
    t.string   "key"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "admin_users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "role",                               :null => false
    t.string   "email",                              :null => false
    t.string   "password_digest",                    :null => false
    t.string   "preferences"
    t.boolean  "status",          :default => false
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "animals", :force => true do |t|
    t.string "name", :null => false
    t.string "type"
  end

  create_table "articles", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "assets", :force => true do |t|
    t.string   "caption"
    t.string   "dragonfly_uid"
    t.string   "dragonfly_required_uid"
    t.string   "paperclip_file_name"
    t.string   "paperclip_content_type"
    t.integer  "paperclip_file_size"
    t.datetime "paperclip_updated_at"
    t.string   "paperclip_required_file_name"
    t.string   "paperclip_required_content_type"
    t.integer  "paperclip_required_file_size"
    t.datetime "paperclip_required_updated_at"
  end

  create_table "categories", :force => true do |t|
    t.string  "name"
    t.string  "permalink"
    t.text    "description"
    t.integer "position"
  end

  create_table "categories_entries", :id => false, :force => true do |t|
    t.integer "category_id"
    t.integer "entry_id"
  end

  create_table "categories_posts", :id => false, :force => true do |t|
    t.integer "category_id"
    t.integer "post_id"
  end

  add_index "categories_posts", ["category_id"], :name => "index_categories_posts_on_category_id"
  add_index "categories_posts", ["post_id"], :name => "index_categories_posts_on_post_id"

  create_table "comments", :force => true do |t|
    t.string  "email"
    t.string  "name"
    t.text    "body"
    t.integer "post_id"
    t.boolean "spam",    :default => false
  end

  add_index "comments", ["post_id"], :name => "index_comments_on_post_id"

  create_table "delayed_tasks", :force => true do |t|
    t.string "name"
  end

  create_table "devise_users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "devise_users", ["email"], :name => "index_devise_users_on_email", :unique => true
  add_index "devise_users", ["reset_password_token"], :name => "index_devise_users_on_reset_password_token", :unique => true

  create_table "entries", :force => true do |t|
    t.string   "title",                         :null => false
    t.text     "content"
    t.string   "type"
    t.boolean  "published",  :default => false, :null => false
    t.datetime "deleted_at"
  end

  create_table "image_holders", :force => true do |t|
    t.string  "name"
    t.integer "imageable_id"
    t.string  "imageable_type"
  end

  create_table "invoices", :force => true do |t|
    t.string   "number"
    t.integer  "order_id"
    t.integer  "typus_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", :force => true do |t|
    t.string   "number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", :force => true do |t|
    t.string  "title"
    t.text    "body"
    t.boolean "status"
    t.integer "parent_id"
  end

  add_index "pages", ["parent_id"], :name => "index_pages_on_parent_id"

  create_table "pictures", :force => true do |t|
    t.string   "title"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.integer  "typus_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pictures", ["typus_user_id"], :name => "index_pictures_on_typus_user_id"

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.string   "status",              :default => "draft", :null => false
    t.integer  "favorite_comment_id"
    t.datetime "published_at"
    t.integer  "typus_user_id"
    t.boolean  "published"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "numeric_status",      :default => 0,       :null => false
  end

  add_index "posts", ["favorite_comment_id"], :name => "index_posts_on_favorite_comment_id"
  add_index "posts", ["typus_user_id"], :name => "index_posts_on_typus_user_id"

  create_table "project_collaborators", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.integer  "project_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", :force => true do |t|
    t.string   "name",       :null => false
    t.integer  "user_id",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sites", :force => true do |t|
    t.string "name",   :null => false
    t.string "domain", :null => false
  end

  create_table "tasks", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "status"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tasks", ["project_id"], :name => "index_tasks_on_project_id"

  create_table "typus_users", :force => true do |t|
    t.string   "first_name",       :default => "",    :null => false
    t.string   "last_name",        :default => "",    :null => false
    t.string   "role",                                :null => false
    t.string   "email",                               :null => false
    t.boolean  "status",           :default => false
    t.string   "token",                               :null => false
    t.string   "salt",                                :null => false
    t.string   "crypted_password",                    :null => false
    t.string   "preferences"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "typus_users", ["token"], :name => "index_typus_users_on_token"

  create_table "users", :force => true do |t|
    t.string   "name",                                :null => false
    t.string   "first_name",       :default => ""
    t.string   "last_name",        :default => ""
    t.string   "role"
    t.string   "email",                               :null => false
    t.boolean  "status",           :default => false
    t.string   "token"
    t.string   "salt"
    t.string   "crypted_password"
    t.string   "preferences"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "views", :force => true do |t|
    t.string   "ip",         :default => "127.0.0.1"
    t.integer  "post_id"
    t.integer  "site_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "views", ["post_id"], :name => "index_views_on_post_id"

end
