require "kemal"
require "sentry-run"
require "json"
require "sqlite3"
require "./hibari/*"
require "./json_api/*"
require "./kitsu/*"

process = Sentry.config(
  process_name: "API",
  build_command: "crystal",
  run_command: "./api",
  build_args: [ "build", "src/api.cr", "-o", "./api"],
  should_build: true
)

db_url = "sqlite3://./db/sqlite3.db"
puts "opening #{db_url}"
db = DB.open db_url

def table_names(db)
  sql = "SELECT name FROM sqlite_master WHERE type='table';"
  db.query_all(sql, as: String)
end

serve_static false
gzip true

module Hibari
  before_all do |env|
    headers env, Hibari::HEADERS
  end

  get "/" do |env|
    table_names(db).to_json
  end

  get "/:table_name" do |env|
    table_name = env.params.url["table_name"]
    unless table_names(db).includes?(table_name)
      # Ignore nonexistent table requests
      env.response.status_code = 404
    else
      sql = "select * from #{table_name}"
      db.query sql do |rs|
        JsonAPI.response(rs.column_names, rs)
      end
    end
  end

  get "/:table_name/:id" do |env|
    table_name = env.params.url["table_name"]
    id = env.params.url["id"]

    unless table_names(db).includes?(table_name)
      env.response.status_code = 404
    else
      db.query "select * from #{table_name} where id = #{id}" do |rs|
      JsonAPI.response(rs.column_names, rs)
      end
    end
  end

  if ENV.has_key?("KEMAL_ENV")
    Kemal.run
  else
    Sentry.run(process) do
      Kemal.run
    end
  end
end

db.close
