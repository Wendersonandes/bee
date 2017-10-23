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

ActiveRecord::Schema.define(version: 20171022151852) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "car_comments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "carrinho_id"
    t.text     "content"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "car_comments", ["carrinho_id"], name: "index_car_comments_on_carrinho_id", using: :btree
  add_index "car_comments", ["user_id"], name: "index_car_comments_on_user_id", using: :btree

  create_table "carrinhos", force: :cascade do |t|
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "user_id"
    t.string   "buyer_name"
    t.string   "email"
    t.string   "cpf"
    t.string   "reference"
    t.string   "status"
    t.float    "price"
    t.string   "street"
    t.string   "number"
    t.string   "complement"
    t.string   "district"
    t.string   "city"
    t.string   "state"
    t.string   "postal_code"
    t.float    "frete"
  end

  create_table "colors", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "colors_materials", id: false, force: :cascade do |t|
    t.integer "color_id",    null: false
    t.integer "material_id", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "post_id"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "comments", ["post_id"], name: "index_comments_on_post_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "contatos", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "mensagem"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "follows", force: :cascade do |t|
    t.integer  "following_id", null: false
    t.integer  "follower_id",  null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "follows", ["follower_id"], name: "index_follows_on_follower_id", using: :btree
  add_index "follows", ["following_id", "follower_id"], name: "index_follows_on_following_id_and_follower_id", unique: true, using: :btree
  add_index "follows", ["following_id"], name: "index_follows_on_following_id", using: :btree

  create_table "marcas", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "materials", force: :cascade do |t|
    t.string   "name"
    t.integer  "printer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float    "preco"
    t.float    "potencia"
    t.float    "densidade"
  end

  add_index "materials", ["printer_id"], name: "index_materials_on_printer_id", using: :btree

  create_table "mats", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float    "potencia"
    t.float    "densidade"
  end

  create_table "modelos", force: :cascade do |t|
    t.string   "name"
    t.integer  "marca_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float    "desgaste"
  end

  create_table "notifications", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "notified_by_id"
    t.integer  "post_id"
    t.integer  "identifier"
    t.string   "notice_type"
    t.boolean  "read",           default: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "status"
  end

  add_index "notifications", ["notified_by_id"], name: "index_notifications_on_notified_by_id", using: :btree
  add_index "notifications", ["post_id"], name: "index_notifications_on_post_id", using: :btree
  add_index "notifications", ["user_id"], name: "index_notifications_on_user_id", using: :btree

  create_table "oferts", force: :cascade do |t|
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.float    "price"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "user_id"
    t.integer  "post_id"
    t.string   "material"
    t.string   "color"
    t.string   "resolution"
    t.string   "preench"
    t.integer  "printer_id"
    t.integer  "carrinho_id"
    t.integer  "quantidade"
    t.float    "scale"
    t.float    "peso"
  end

  create_table "ped_comments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "pedido_id"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "ped_comments", ["pedido_id"], name: "index_ped_comments_on_pedido_id", using: :btree
  add_index "ped_comments", ["user_id"], name: "index_ped_comments_on_user_id", using: :btree

  create_table "pedidos", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string   "caption"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "user_id"
    t.string   "attachment"
    t.integer  "cached_votes_total", default: 0
    t.integer  "cached_votes_score", default: 0
    t.integer  "cached_votes_up",    default: 0
    t.integer  "cached_votes_down",  default: 0
    t.float    "volume"
    t.integer  "view",               default: 0
    t.float    "preco",              default: 0.0
    t.integer  "status",             default: 1
    t.float    "x"
    t.float    "y"
    t.float    "z"
    t.integer  "prints",             default: 0
    t.float    "area"
  end

  add_index "posts", ["cached_votes_down"], name: "index_posts_on_cached_votes_down", using: :btree
  add_index "posts", ["cached_votes_score"], name: "index_posts_on_cached_votes_score", using: :btree
  add_index "posts", ["cached_votes_total"], name: "index_posts_on_cached_votes_total", using: :btree
  add_index "posts", ["cached_votes_up"], name: "index_posts_on_cached_votes_up", using: :btree
  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree

  create_table "posts_types", id: false, force: :cascade do |t|
    t.integer "type_id", null: false
    t.integer "post_id", null: false
  end

  create_table "printers", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.string   "marca"
    t.string   "modelo"
    t.string   "active"
    t.float    "kwh"
    t.float    "desgaste"
  end

  add_index "printers", ["user_id"], name: "index_printers_on_user_id", using: :btree

  create_table "types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.text     "bio"
    t.string   "name"
    t.string   "sobrenome"
    t.string   "completo"
    t.integer  "seguidores",             default: 0
    t.string   "provider"
    t.string   "uid"
    t.string   "image"
    t.string   "prof"
    t.string   "city"
    t.string   "niver"
    t.string   "user_name"
    t.integer  "view",                   default: 0
    t.string   "conta_pais"
    t.string   "conta_nome"
    t.string   "conta_sobrenome"
    t.string   "conta_cpf"
    t.string   "conta_banco"
    t.string   "conta_agencia"
    t.string   "conta_tipo"
    t.string   "conta_num"
    t.string   "tipo"
    t.string   "cpf"
    t.string   "phone_code"
    t.string   "phone_number"
    t.string   "birthday"
    t.string   "street"
    t.string   "number"
    t.string   "complement"
    t.string   "district"
    t.string   "city_pag"
    t.string   "state"
    t.string   "postal_code"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "votes", force: :cascade do |t|
    t.integer  "votable_id"
    t.string   "votable_type"
    t.integer  "voter_id"
    t.string   "voter_type"
    t.boolean  "vote_flag"
    t.string   "vote_scope"
    t.integer  "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope", using: :btree
  add_index "votes", ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope", using: :btree

  add_foreign_key "car_comments", "carrinhos"
  add_foreign_key "car_comments", "users"
  add_foreign_key "comments", "posts"
  add_foreign_key "comments", "users"
  add_foreign_key "materials", "printers"
  add_foreign_key "notifications", "posts"
  add_foreign_key "notifications", "users"
  add_foreign_key "notifications", "users", column: "notified_by_id"
  add_foreign_key "ped_comments", "pedidos"
  add_foreign_key "ped_comments", "users"
  add_foreign_key "posts", "users"
  add_foreign_key "printers", "users"
end
