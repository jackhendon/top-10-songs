class Api::SongsController < ApplicationController
  def index
  artist = params[:artist]
  return render json: { error: "Artist name required" }, status: 400 if artist.blank?

    begin
      spotify = SpotifyService.new
      artist_id = spotify.get_artist_id(artist)
      return render json: { error: "Artist not found on Spotify" }, status: 404 if artist_id.nil?

      songs_url = "https://kworb.net/spotify/artist/#{artist_id}_songs.html"
      response = HTTParty.get(songs_url)

      if response.code != 200
        return render json: { error: "Artist found on Spotify, but not on Kworb" }, status: 404
      end

      songs_html = response.body
      songs_doc = Nokogiri::HTML(songs_html)

      Rails.logger.debug("Kworb HTML preview: #{songs_html[0..500]}")
      tables = songs_doc.css("table")
      table = tables[1]  # second table on the page
      rows = table.css("tr")[1..] || []


      Rails.logger.debug("Parsed #{rows.length} song rows")

    songs = rows.each_with_index.map do |row, i|
      cols = row.css("td")
      title_link = cols[0]&.at_css("a")
      stream_count = cols[1]&.text&.strip

      {
        title: title_link&.text&.strip || "Unknown",
        rank: i + 1,
        streams: stream_count
      }
    end



      render json: songs
    rescue => e
      Rails.logger.error("Error in SongsController: #{e.message}")
      render json: { error: "Failed to fetch songs" }, status: 500
    end
  end
end
