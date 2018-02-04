module JsonAPI
  def response(col_names, rs)
    JSON.build do |json|
      json.object do
        construct_data json, col_names, rs
      end
    end
  end
end
