module Hibari
  def table_names(db)
    sql = "SELECT name FROM sqlite_master WHERE type='table';"
    db.query_all sql, as: String
  end
end
