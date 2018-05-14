module Hibari::Routes
  get "/" do |env|
    Hibari::JsonAPI.error 501, "Not Implemented"
  end
end
