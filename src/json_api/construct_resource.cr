module Hibari::JsonAPI
  # Creates the JSON:API resource object
  #
  # Returns the following JSON structure:
  #
  # ```json
  # {
  #   "col_name": "value",
  #   ...
  # }
  # ```
  def construct_resource(json, col_names, rs)
    json.object do
      col_names.each do |col|
        construct_field json, col, rs.read
      end
    end
  end
end
