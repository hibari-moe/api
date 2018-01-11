module Hibari
  def kitsu_get(path, params = nil)
    uri = URI.parse("https://kitsu.io/api/edge/" + path)
    uri.query = params
    response = HTTP::Client.get(uri, headers: HTTP::Headers { "User-Agent" => "hibari-api/#{Hibari::VERSION}/#{Crystal::VERSION}" })
    JSON.parse(response.body)
  end
end
