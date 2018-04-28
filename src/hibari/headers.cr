module Hibari
  # Response headers for the Hibari API
  HEADERS = {
    "Content-Type" => JsonAPI::CONTENT_TYPE,
    "Strict-Transport-Security" => "max-age=63072000; includeSubDomains; preload",
    "X-Powered-By" => "", # TODO: Remove this header entirely
    "X-Frame-Options" => "SAMEORIGIN",
    "X-Xss-Protection" => "1; mode=block",
    "X-Content-Type-Options" => "nosniff",
    "Referrer-Policy" => "strict-origin-when-cross-origin"
  }
end
