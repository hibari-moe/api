module Kitsu
  def get(path, params = nil)
    uri = URI.parse(BASE_URL + path)
    uri.query = params
    response = HTTP::Client.get(uri, headers: HTTP::Headers { "User-Agent" => "hibari-api/#{Hibari::VERSION}/#{Crystal::VERSION} (wopian/hibari-api)" })
    JSON.parse(response.body)
  end
end
