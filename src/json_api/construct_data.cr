module Hibari::JsonAPI
  # Creates the data array of the JSON:API response
  #
  # Returns the following JSON structure:
  #
  # ```json
  # {
  #   "data": [
  #     { ... }
  #   ]
  # }
  # ```
  def construct_data(json, col_names, rs)
    json.field "data" do
      json.array do
        rs.each do
          construct_resource json, col_names, rs
        end
      end
    end
  end
end
