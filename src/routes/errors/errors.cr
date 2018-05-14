# Error endpoints for the Hibari API.
#
# Each error returns a JSON:API formatted error response
module Hibari::Routes::Errors
  extend self

  # Sets the response headers for each error endpoint
  #
  # TODO: Find why before_all doesn't apply to error endpoints
  def set_error_headers(env)
    headers env, Hibari::HEADERS
  end

  error 400 do |env|
    set_error_headers env
    Hibari::JsonAPI.error 400, "Bad Request"
  end

  error 403 do |env|
    set_error_headers env
    Hibari::JsonAPI.error 403, "Forbidden"
  end

  error 404 do |env|
    set_error_headers env
    Hibari::JsonAPI.error 404, "Not Found"
  end

  error 415 do |env|
    set_error_headers env
    Hibari::JsonAPI.error 415, "Unsupported Media Type", "Missing 'application/vnd.api+json' from the Content-Type header"
  end

  error 422 do |env|
    set_error_headers env
    Hibari::JsonAPI.error 422, "Unprocessable Entity"
  end

  error 500 do |env|
    set_error_headers env
    Hibari::JsonAPI.error 500, "Internal Server Error"
  end

  error 501 do |env|
    set_error_headers env
    Hibari::JsonAPI.error 501, "Not Implemented"
  end
end
