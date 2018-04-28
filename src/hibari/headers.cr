module Hibari
  # Response headers for the Hibari API
  HEADERS = {
    "Content-Type" => JsonAPI::CONTENT_TYPE,
    "Strict-Transport-Security" => "max-age=63072000; includeSubDomains; preload",
    "Content-Security-Policy" => "default-src 'none'",
    "Cache-Control" => "public, max-age=900, s-maxage=900",
    "X-Frame-Options" => "SAMEORIGIN",
    "X-XSS-Protection" => "1; mode=block",
    "X-Content-Type-Options" => "nosniff",
    "Referrer-Policy" => "strict-origin-when-cross-origin"
  }
end
