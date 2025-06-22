require "httparty"
require "nokogiri"

class Api::SongsController < ApplicationController
  def index
    artist = params[:artist]
    return render json: { error: "Artist required" }, status: 400 if artist.blank?

    begin
      # Normalize the artist name for matching
      search_name = artist.downcase.gsub(/[^a-z0-9]/, "").sub(/^the/, "")
      index_url = "https://kworb.net/spotify/artist/"
      index_html = HTTParty.get(index_url).body
      index_doc = Nokogiri::HTML(index_html)

      # Find the artist link that matches
      artist_link = index_doc.css("a").find do |link|
        link["href"]&.include?("/spotify/artist/") && link.text.downcase.include?(search_name)
      end

      return render json: { error: "Artist not found on Kworb" }, status: 404 if artist_link.nil?

      artist_id = artist_link["href"].split("/").last.gsub(".html", "")
      songs_url = "https://kworb.net/spotify/artist/#{artist_id}_songs.html"
      songs_html = HTTParty.get(songs_url).body
      songs_doc = Nokogiri::HTML(songs_html)

      rows = songs_doc.css("#spotify tr")[1..] # Skip header
      songs = rows.each_with_index.map do |row, i|
        cols = row.css("td")
        {
          title: cols[1].text.strip,
          rank: i + 1
        }
      end

      render json: songs
    rescue => e
      Rails.logger.error e.message
      render json: { error: "Failed to fetch songs" }, status: 500
    end
  end
end
