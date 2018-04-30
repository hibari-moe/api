module Hibari::Routes
  before_all do |env|
    headers env, HEADERS
  end
end
