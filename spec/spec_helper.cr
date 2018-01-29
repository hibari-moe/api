ENV["KEMAL_ENV"] ||= "test"

require "spec-kemal"
require "../src/api"

Spec.before_each do
  config = Kemal.config
  config.env = "test"
  config.setup
end

Spec.after_each do
  Kemal.config.clear
end
