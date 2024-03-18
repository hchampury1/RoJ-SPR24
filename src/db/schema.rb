# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2024_02_11_060949) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.text "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.text "key", null: false
    t.text "filename", null: false
    t.text "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.text "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "app_configs", force: :cascade do |t|
    t.text "name", default: "AMSTR"
    t.text "logo_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "calls", force: :cascade do |t|
    t.string "caller_type"
    t.string "name"
    t.string "phone_number"
    t.string "inmate_num"
    t.string "institution"
    t.string "location"
    t.string "point_of_contact"
    t.date "date"
    t.string "notes"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "call_status"
  end

  create_table "counties", force: :cascade do |t|
    t.text "name"
    t.integer "num_cur_cases"
    t.integer "num_cur_cases_b"
    t.integer "num_cur_cases_w"
    t.integer "num_cur_cases_o"
    t.integer "population"
    t.integer "num_dr"
    t.integer "num_dr_b"
    t.integer "num_dr_w"
    t.integer "num_dr_o"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "donations", force: :cascade do |t|
    t.string "guid"
    t.string "lawyername"
    t.string "caseaddress"
    t.string "lawfirm"
    t.string "name"
    t.date "date"
    t.float "hours"
    t.text "description"
    t.bigint "user_id"
    t.bigint "project_id"
    t.bigint "entered_by_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "fees"
    t.index ["entered_by_id"], name: "index_donations_on_entered_by_id"
    t.index ["project_id"], name: "index_donations_on_project_id"
    t.index ["user_id"], name: "index_donations_on_user_id"
  end

  create_table "donors", force: :cascade do |t|
    t.string "email"
    t.string "phoneNumber"
    t.string "location"
    t.string "donor_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "event_details", force: :cascade do |t|
    t.string "title"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string "speakers"
    t.text "description"
    t.text "event_link"
    t.string "created_by"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "inkindentries", force: :cascade do |t|
    t.bigint "inkind_id", null: false
    t.string "description"
    t.float "hours"
    t.integer "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["inkind_id"], name: "index_inkindentries_on_inkind_id"
  end

  create_table "inkinds", force: :cascade do |t|
    t.string "name"
    t.date "date"
    t.integer "value"
    t.string "description"
    t.string "user"
    t.string "genre"
    t.string "donor_name", default: ""
    t.bigint "donor_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "hours"
    t.index ["donor_id"], name: "index_inkinds_on_donor_id"
  end

  create_table "job_types", force: :cascade do |t|
    t.string "name"
    t.decimal "fee", precision: 8, scale: 2
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "joins", force: :cascade do |t|
    t.integer "mail_id"
    t.integer "tag_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "mail_entries", force: :cascade do |t|
    t.text "label"
    t.date "date"
    t.text "sender_name"
    t.integer "inmate_id"
    t.integer "case_status"
    t.integer "current_age"
    t.integer "crime_age"
    t.text "victim_race"
    t.text "offender_race"
    t.text "inquiryType"
    t.text "pdf"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "relevant_staff"
    t.string "home_institution"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "product_id"
    t.integer "user_id"
    t.integer "status"
    t.string "token"
    t.string "charge_id"
    t.string "error_message"
    t.string "customer_id"
    t.integer "payment_gateway"
    t.integer "price_cents", default: 0, null: false
    t.string "price_currency", default: "USD", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.integer "price_cents", default: 0, null: false
    t.string "price_currency", default: "USD", null: false
  end

  create_table "projects", force: :cascade do |t|
    t.text "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_projects_on_name", unique: true
  end

  create_table "projects_users", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "project_id"
    t.index ["user_id", "project_id"], name: "index_projects_users_on_user_id_and_project_id"
  end

  create_table "registrants", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "webinar"
    t.string "county"
    t.string "job"
    t.boolean "listserv"
    t.text "topics"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "deregistered"
    t.integer "amount"
    t.boolean "paid"
    t.string "state"
    t.string "cleID", default: "None"
  end

  create_table "registrants_webinars", force: :cascade do |t|
    t.bigint "registrant_id", null: false
    t.bigint "webinar_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["registrant_id"], name: "index_registrants_webinars_on_registrant_id"
    t.index ["webinar_id"], name: "index_registrants_webinars_on_webinar_id"
  end

  create_table "reminders", force: :cascade do |t|
    t.text "mail_entry_id"
    t.text "user_email"
    t.text "username"
    t.text "notes"
    t.date "reminder_time"
    t.text "priority"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_reminders_on_deleted_at"
  end

  create_table "requests", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "request"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "responses", force: :cascade do |t|
    t.boolean "response_sent"
    t.text "response_message"
    t.date "date_sent"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "mailid"
    t.string "maillabel"
  end

  create_table "speakers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "description"
    t.string "link"
  end

  create_table "states", force: :cascade do |t|
    t.string "name", null: false
    t.string "abbreviation", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tags", force: :cascade do |t|
    t.text "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.text "email", default: "", null: false
    t.text "encrypted_password", default: "", null: false
    t.text "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "first_name"
    t.string "last_name"
    t.integer "role"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "webinars", force: :cascade do |t|
    t.string "webinar_name"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "date_and_time"
    t.integer "csvEntry"
  end

  create_table "webinars_speakers", force: :cascade do |t|
    t.integer "webinar_id", null: false
    t.integer "speaker_id", null: false
  end

  create_table "worklogs", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "project_id"
    t.text "desc_summary"
    t.text "desc_body", default: ""
    t.float "hours"
    t.decimal "fee"
    t.date "date"
    t.bigint "entered_by_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["entered_by_id"], name: "index_worklogs_on_entered_by_id"
    t.index ["project_id"], name: "index_worklogs_on_project_id"
    t.index ["user_id"], name: "index_worklogs_on_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "donations", "projects"
  add_foreign_key "donations", "users"
  add_foreign_key "donations", "users", column: "entered_by_id"
  add_foreign_key "inkindentries", "inkinds"
  add_foreign_key "inkinds", "donors"
  add_foreign_key "registrants_webinars", "registrants"
  add_foreign_key "registrants_webinars", "webinars"
  add_foreign_key "webinars_speakers", "speakers"
  add_foreign_key "webinars_speakers", "webinars"
  add_foreign_key "worklogs", "projects"
  add_foreign_key "worklogs", "users"
  add_foreign_key "worklogs", "users", column: "entered_by_id"
end
