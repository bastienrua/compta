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

ActiveRecord::Schema.define(:version => 20101025223912) do

  create_table "clients", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contracts", :force => true do |t|
    t.integer  "client_id"
    t.decimal  "amount_excl_vat"
    t.decimal  "vat"
    t.date     "issued_on"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
  end

  add_index "contracts", ["client_id"], :name => "index_contracts_on_client_id"

  create_table "invoice_lines", :force => true do |t|
    t.integer  "contract_id"
    t.text     "description"
    t.decimal  "amount_excl_vat"
    t.integer  "invoice_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "invoice_lines", ["contract_id"], :name => "index_invoice_lines_on_contract_id"
  add_index "invoice_lines", ["invoice_id"], :name => "index_invoice_lines_on_invoice_id"

  create_table "invoices", :force => true do |t|
    t.string   "number"
    t.decimal  "vat"
    t.integer  "client_id"
    t.date     "invoiced_on"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "invoices", ["client_id"], :name => "index_invoices_on_client_id"

end
