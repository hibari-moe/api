module Hibari
  # Creates a hash map of all the tables in the database
  def table_names(db)
    sql = "SELECT name FROM sqlite_master WHERE type='table';"
    db.query_all sql, as: String
  end
end
