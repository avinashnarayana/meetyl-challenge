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

ActiveRecord::Schema.define(version: 20170529234146) do

  create_table "invitations", force: :cascade do |t|
    t.integer  "meeting_id"
    t.integer  "invitee_id"
    t.string   "response"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["meeting_id", "invitee_id"], name: "index_invitations_on_meeting_id_and_invitee_id", unique: true
    t.index ["meeting_id"], name: "index_invitations_on_meeting_id"
  end

  create_table "meetings", force: :cascade do |t|
    t.integer  "inviter_id"
    t.string   "subject"
    t.string   "location"
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "max_size"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
