# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_09_08_160101) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "articulos", force: :cascade do |t|
    t.string "marca"
    t.string "modelo"
    t.date "fecha_ingreso"
    t.bigint "portador_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["portador_id"], name: "index_articulos_on_portador_id"
  end

  create_table "personas", force: :cascade do |t|
    t.string "nombre"
    t.string "apellido"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "ip_address"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "transferencias", force: :cascade do |t|
    t.bigint "articulo_id", null: false
    t.bigint "portador_anterior_id", null: false
    t.bigint "nuevo_portador_id", null: false
    t.date "fecha"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["articulo_id"], name: "index_transferencias_on_articulo_id"
    t.index ["nuevo_portador_id"], name: "index_transferencias_on_nuevo_portador_id"
    t.index ["portador_anterior_id"], name: "index_transferencias_on_portador_anterior_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  add_foreign_key "articulos", "personas", column: "portador_id"
  add_foreign_key "sessions", "users"
  add_foreign_key "transferencias", "articulos"
  add_foreign_key "transferencias", "personas", column: "nuevo_portador_id"
  add_foreign_key "transferencias", "personas", column: "portador_anterior_id"
end
