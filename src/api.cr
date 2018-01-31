require "http/client"
require "uri"
require "kemal"
require "sentry-run"
require "json"
require "sqlite3"
require "./api/*"

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
    env.response.content_type = CONTENT_TYPE
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
        write_json_response(rs.column_names, rs)
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
        write_json_response(rs.column_names, rs)
      end
    end
  end

  def write_json_response(col_names, rs)
    JSON.build do |json|
      json.object do
        json.field "data" do
          json.array do
            rs.each do
              json.object do
                col_names.each do |col|
                  json_encode_field json, col, rs.read
                end
              end
            end
          end
        end
      end
    end
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
    Sentry.run(process) do
      Kemal.run
    end
  end
end

include Hibari

db.close
