require "httparty"

class SpotifyService
  TOKEN_URL = "https://accounts.spotify.com/api/token"
  SEARCH_URL = "https://api.spotify.com/v1/search"

  def initialize
    @client_id = ENV["SPOTIFY_CLIENT_ID"]
    @client_secret = ENV["SPOTIFY_CLIENT_SECRET"]
    @token = fetch_token
  end

def fetch_token
  auth = Base64.strict_encode64("#{@client_id}:#{@client_secret}")
  response = HTTParty.post(TOKEN_URL,
    headers: {
      "Authorization" => "Basic #{auth}",
      "Content-Type" => "application/x-www-form-urlencoded"
    },
    body: { grant_type: "client_credentials" }
  )

  Rails.logger.debug("SPOTIFY TOKEN: #{response.parsed_response.inspect}")

  response.parsed_response["access_token"]
end

def get_artist_id(artist_name)
  response = HTTParty.get(SEARCH_URL, {
    headers: { "Authorization" => "Bearer #{@token}" },
    query: { q: artist_name, type: "artist", limit: 1 }
  })

  Rails.logger.debug("SPOTIFY SEARCH: #{response.parsed_response.inspect}")

  item = response.dig("artists", "items", 0)
  item ? item["id"] : nil
end
end
