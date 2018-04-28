module Hibari
  # Response headers for the Hibari API
  HEADERS = {
    "Content-Type" => JsonAPI::CONTENT_TYPE,
    "Strict-Transport-Security" => "max-age=63072000; includeSubDomains; preload",
    "Content-Security-Policy" => "default-src 'none'",
    "Cache-Control" => "max-age=86400",
    "Server" => "api.hibari.moe",
    "X-Powered-By" => "api.hibari.moe",
    "X-Frame-Options" => "SAMEORIGIN",
    "X-XSS-Protection" => "1; mode=block",
    "X-Content-Type-Options" => "nosniff",
    "Referrer-Policy" => "origin-when-cross-origin, strict-origin-when-cross-origin"
  }
end
