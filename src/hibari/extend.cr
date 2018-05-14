require "../routes/*"
require "../routes/errors/*"

module Hibari
  extend self
  extend Hibari::Routes::Errors
  extend Hibari::Routes
end
