require "http/client"
require "uri"

module Kitsu
  def get(resource, params = nil)
    uri = URI.parse(BASE_URL + resource)
    uri.query = params.to_s

    response = HTTP::Client.get(uri, headers: HTTP::Headers {
      "Content-Type" => JsonAPI::CONTENT_TYPE,
      "Accepts" => JsonAPI::CONTENT_TYPE,
      "User-Agent" => "hibari-api/#{Hibari::VERSION}/#{Crystal::VERSION} (wopian/hibari-api)"
    })

    JSON.parse response.body
  end
end
