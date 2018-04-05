module Hibari::JsonAPI
  alias NotSupported = Char | JSON::Any

  # Creates the fields of JSON:API responses
  #
  # Returns the following JSON structures:
  #
  # ```json
  # "key": "value"
  # ```
  #
  # ```json
  # "key": [ "value" ]
  # ```
  def construct_field(json, col, value)
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
        value.to_json json
      end
    end
  end
end
