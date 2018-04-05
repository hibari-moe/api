require "http/client"
require "uri"

module Hibari::Kitsu
  def get(resource, params = nil)
    uri = URI.parse(BASE_URL + resource)
    uri.query = params.to_s

    response = HTTP::Client.get(uri, headers: HTTP::Headers {
      "Content-Type" => Hibari::JsonAPI::CONTENT_TYPE,
      "Accepts" => Hibari::JsonAPI::CONTENT_TYPE,
      "User-Agent" => "hibari-api/#{Hibari::VERSION}/#{Crystal::VERSION} (wopian/hibari-api)"
    })

    JSON.parse response.body
  end
end
