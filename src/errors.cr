module Errors
  error 400 do |env|
    JsonAPI.error 400, "Bad Request"
  end

  error 403 do |env|
    JsonAPI.error 403, "Forbidden"
  end

  error 404 do |env|
    JsonAPI.error 404, "Not Found"
  end

  error 415 do |env|
    JsonAPI.error 415, "Unsupported Media Type"
  end

  error 422 do |env|
    JsonAPI.error 422, "Unprocessable Entity"
  end

  error 500 do |env|
    JsonAPI.error 500, "Internal Server Error"
  end

  error 501 do |env|
    JsonAPI.error 501, "Not Implemented"
  end
end
