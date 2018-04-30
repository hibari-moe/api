require "db"
require "sqlite3"
require "crecto"
require "./models/*"

module Repo
  extend Crecto::Repo

  config do |conf|
    conf.adapter = Crecto::Adapters::SQLite3
    conf.database = "./db/sqlite3.db"
  end
end
