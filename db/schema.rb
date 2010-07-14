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

ActiveRecord::Schema.define(:version => 20100714031628) do

  create_table "asset_types", :force => true do |t|
    t.string   "description"
    t.boolean  "streaming"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "assets", :force => true do |t|
    t.integer  "video_id"
    t.integer  "asset_type_id"
    t.string   "data_file_name"
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.datetime "data_updated_at"
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "conferences", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", :force => true do |t|
    t.string   "short_code"
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "logo"
    t.string   "url"
    t.string   "slug_date_format",  :default => "%Y-%m-%d-%H-%M-"
    t.string   "slug_format_data",  :default => "display_presenters, title"
    t.integer  "conference_id"
    t.string   "date_occured"
    t.string   "name_suffix"
    t.string   "name_prefix"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.string   "joiner",            :default => "-"
    t.string   "image_extension",   :default => "png"
    t.string   "video_extension"
  end

  create_table "presentations", :force => true do |t|
    t.integer  "presenter_id"
    t.integer  "video_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "presenters", :force => true do |t|
    t.string   "aka_name"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "last_login_date"
    t.string   "time_zone"
    t.string   "session_token"
    t.boolean  "admin",               :default => false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "gender"
    t.string   "location"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "twitter_name"
    t.string   "facebook_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "videos", :force => true do |t|
    t.string   "title"
    t.datetime "recorded_at"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "available"
    t.string   "display_format"
    t.string   "prefix"
    t.string   "override"
  end

end
