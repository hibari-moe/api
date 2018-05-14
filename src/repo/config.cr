require "db"
require "sqlite3"
require "crecto"
require "./models/*"

# Log database commands during development
unless ENV.has_key? "KEMAL_ENV"
  file = File.open("db/crecto.log", "w")
  file.sync = true
  Crecto::DbLogger.set_handler(file)
end

module Repo
  extend Crecto::Repo

  config do |conf|
    conf.adapter = Crecto::Adapters::SQLite3
    conf.database = "./db/sqlite3.db"
  end
end
