require "http/client"
require "uri"
require "kemal"
require "sentry-run"
require "json"
require "sqlite3"
require "./api/*"

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
    env.response.content_type = CONTENT_TYPE
  end

  get "/" do |env|
    env.response.content_type = "application/json"
    table_names(db).to_json
  end

  get "/:table_name" do |env|
    env.response.content_type = "application/json"
    table_name = env.params.url["table_name"]
    unless table_names(db).includes?(table_name)
      # Ignore nonexistent table requests
      env.response.status_code = 404
    else
      db.query "select * from #{table_name}" do |rs|
        col_names = rs.column_names
        rs.each do
          write_ndjson(env.response.output, col_names, rs)
          # force chunked response even on small tables
          env.response.output.flush
        end
      end
    end
  end

  def write_ndjson(io, col_names, rs)
    JSON.build(io) do |json|
      json.object do
        col_names.each do |col|
          json_encode_field json, col, rs.read
        end
      end
    end
    io << "\n"
  end

  def json_encode_field(json, col, value)
    case value
    when Bytes
      # custom json encoding. Avoid extra allocations
      json.field col do
        json.array do
          value.each do |e|
            json.scalar e
          end
        end
      end
    when NotSupported
      # do not include column as a json field
    else
      # encode the value as their built in json format
      json.field col do
        value.to_json(json)
      end
    end
  end

  alias NotSupported = Char | JSON::Any

  if ENV.has_key?("CRYSTAL_ENV")
    Kemal.run
  else
    process = Sentry.config(
      process_name: "API",
      build_command: "crystal",
      run_command: "./api"
    )
    Sentry.run(process) do
      Kemal.run
    end
  end
end

include Hibari

db.close
