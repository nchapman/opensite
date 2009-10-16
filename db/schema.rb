# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20091016040118) do

  create_table "binary_assets", :force => true do |t|
    t.integer  "site_id"
    t.string   "name"
    t.string   "type"
    t.string   "slug"
    t.string   "asset_file_name"
    t.string   "asset_content_type"
    t.integer  "asset_file_size"
    t.datetime "asset_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
  end

  add_index "binary_assets", ["site_id", "slug"], :name => "index_binary_assets_on_site_id_and_slug"
  add_index "binary_assets", ["site_id"], :name => "index_binary_assets_on_site_id"

  create_table "domains", :force => true do |t|
    t.integer  "site_id"
    t.string   "fqdn"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "domains", ["fqdn"], :name => "index_domains_on_fqdn"

  create_table "memberships", :force => true do |t|
    t.integer  "site_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "memberships", ["user_id", "site_id"], :name => "index_memberships_on_user_id_and_site_id"

  create_table "page_parts", :force => true do |t|
    t.integer  "page_id"
    t.string   "name"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "page_parts", ["page_id", "name"], :name => "index_page_parts_on_page_id_and_name"
  add_index "page_parts", ["page_id"], :name => "index_page_parts_on_page_id"

  create_table "pages", :force => true do |t|
    t.integer  "site_id"
    t.string   "title"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "home"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "template_id"
  end

  add_index "pages", ["lft", "rgt"], :name => "index_pages_on_lft_and_rgt"
  add_index "pages", ["parent_id"], :name => "index_pages_on_parent_id"
  add_index "pages", ["site_id", "home"], :name => "index_pages_on_site_id_and_home"
  add_index "pages", ["site_id", "slug"], :name => "index_pages_on_site_id_and_slug"
  add_index "pages", ["site_id"], :name => "index_pages_on_site_id"
  add_index "pages", ["template_id"], :name => "index_pages_on_template_id"

  create_table "sites", :force => true do |t|
    t.string   "name",          :null => false
    t.string   "description"
    t.string   "subdomain",     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
  end

  add_index "sites", ["subdomain"], :name => "index_sites_on_subdomain"

  create_table "snippets", :force => true do |t|
    t.integer  "site_id"
    t.string   "name"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "snippets", ["site_id", "name"], :name => "index_snippets_on_site_id_and_name"
  add_index "snippets", ["site_id"], :name => "index_snippets_on_site_id"

  create_table "templates", :force => true do |t|
    t.integer  "site_id"
    t.string   "name"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
  end

  add_index "templates", ["site_id", "name"], :name => "index_templates_on_site_id_and_name"
  add_index "templates", ["site_id"], :name => "index_templates_on_site_id"

  create_table "textual_assets", :force => true do |t|
    t.string   "name"
    t.integer  "site_id"
    t.string   "type"
    t.string   "content_type"
    t.string   "slug"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
  end

  add_index "textual_assets", ["site_id", "slug"], :name => "index_textual_assets_on_site_id_and_slug"
  add_index "textual_assets", ["site_id"], :name => "index_textual_assets_on_site_id"

  create_table "users", :force => true do |t|
    t.string   "first_name",                         :null => false
    t.string   "last_name",                          :null => false
    t.string   "email",                              :null => false
    t.string   "crypted_password",                   :null => false
    t.string   "password_salt",                      :null => false
    t.string   "persistence_token",                  :null => false
    t.string   "single_access_token",                :null => false
    t.string   "perishable_token",                   :null => false
    t.integer  "login_count",         :default => 0, :null => false
    t.integer  "failed_login_count",  :default => 0, :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
  end

end
