#module Hibari::Routes
#  get "/:table_name" do |env|
#    db = DB.open DB_URL
#    table_name = env.params.url["table_name"]
#    unless Database.table_names(db).includes? table_name
#      env.response.status_code = 404
#    else
#      sql = "select * from #{table_name}"
#      db.query sql do |rs|
#        Hibari::JsonAPI.response rs.column_names, rs
#     end
#    end
#    db.close
#  end
#
#  get "/:table_name/:id" do |env|
#    db = DB.open DB_URL
#    table_name = env.params.url["table_name"]
#    id = env.params.url["id"]
#
#    unless Database.table_names(db).includes? table_name
#      env.response.status_code = 404
#    else
#      db.query "select * from #{table_name} where id = ?", id do |rs|
#        Hibari::JsonAPI.response rs.column_names, rs
#      end
#    end
#    db.close
#  end
#end
