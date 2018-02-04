module Hibari
  HEADERS = {
    "Content-Type" => CONTENT_TYPE,
    "X-Powered-By" => "", # TODO: Remove this header entirely
    "X-Frame-Options" => "SAMEORIGIN",
    "X-Xss-Protection" => "1; mode=block",
    "X-Content-Type-Options" => "nosniff",
    "Referrer-Policy" => "strict-origin-when-cross-origin"
  }
end
