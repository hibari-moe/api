module JsonAPI
  def construct_data(json, col_names, rs)
    json.field "data" do
      json.array do
        rs.each do
          construct_object json, col_names, rs
        end
      end
    end
  end
end
