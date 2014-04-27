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

ActiveRecord::Schema.define(version: 20140325195453) do

  create_table "accessions", force: true do |t|
    t.string   "name"
    t.string   "commercial_name"
    t.string   "clon_name"
    t.string   "synonims"
    t.integer  "oldcode"
    t.integer  "species_id"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "accessions", ["group_id"], name: "index_accessions_on_group_id", using: :btree
  add_index "accessions", ["species_id"], name: "index_accessions_on_species_id", using: :btree

  create_table "blocks", force: true do |t|
    t.integer  "row"
    t.integer  "first_tree"
    t.integer  "last_tree"
    t.integer  "tree_number"
    t.date     "planting_date"
    t.date     "pullout_date"
    t.integer  "collection_id"
    t.integer  "accession_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "blocks", ["accession_id"], name: "index_blocks_on_accession_id", using: :btree
  add_index "blocks", ["collection_id"], name: "index_blocks_on_collection_id", using: :btree

  create_table "collections", force: true do |t|
    t.string   "name"
    t.decimal  "row_distance",  precision: 10, scale: 0
    t.decimal  "tree_distance", precision: 10, scale: 0
    t.integer  "location_id"
    t.integer  "species_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "collections", ["location_id"], name: "index_collections_on_location_id", using: :btree
  add_index "collections", ["species_id"], name: "index_collections_on_species_id", using: :btree

  create_table "countries", force: true do |t|
    t.string   "iso"
    t.string   "name"
    t.string   "nicename"
    t.string   "iso3"
    t.integer  "numcode"
    t.integer  "phonecode"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", force: true do |t|
    t.string   "name"
    t.integer  "species_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "groups", ["species_id"], name: "index_groups_on_species_id", using: :btree

  create_table "locations", force: true do |t|
    t.string   "name"
    t.string   "acronym"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "phenology_records", force: true do |t|
    t.date     "year"
    t.date     "c3"
    t.date     "e2"
    t.date     "f2"
    t.date     "g"
    t.integer  "block_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "phenology_records", ["block_id"], name: "index_phenology_records_on_block_id", using: :btree

  create_table "production_records", force: true do |t|
    t.date     "harvest_date"
    t.integer  "tree_number"
    t.float    "production"
    t.float    "c90"
    t.float    "c8590"
    t.float    "c8085"
    t.float    "c80"
    t.float    "c7580"
    t.float    "c7275"
    t.float    "c7072"
    t.float    "c6870"
    t.float    "c6568"
    t.float    "c65"
    t.float    "c6065"
    t.float    "c5560"
    t.float    "c55"
    t.integer  "block_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "production_records", ["block_id"], name: "index_production_records_on_block_id", using: :btree

  create_table "species", force: true do |t|
    t.string   "name"
    t.string   "latinname"
    t.string   "acronym"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trees", force: true do |t|
    t.integer  "tree"
    t.integer  "row"
    t.date     "planting_date"
    t.date     "pullout_date"
    t.string   "rootstock"
    t.integer  "oldcode"
    t.integer  "oldaccessioncode"
    t.integer  "oldcollectioncode"
    t.integer  "block_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "trees", ["block_id"], name: "index_trees_on_block_id", using: :btree

end
