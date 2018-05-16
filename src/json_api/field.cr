module Hibari::JsonAPI
  def field(json, key, value)
    json.field key do
      json.scalar value
    end
  end
end
