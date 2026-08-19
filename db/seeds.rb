# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require "open-uri"
require "json"
url = "https://api.themoviedb.org/3/movie/top_rated?language=fr-FR&page=1"
genre_url = "https://api.themoviedb.org/3/genre/movie/list"

token = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3MWVlNzRlOTIzNTM5OTAwMTU4NjY1MTE2NmI1YWNiOSIsIm5iZiI6MTc4NjYyODAxMy4yOTcsInN1YiI6IjZhN2RjN2FkZGUyZmI2M2FlNmI3YjIwNCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.OgLg6hLg2MzA_jpKYfBGBDq2nq4wefep19U4C-SvIkk"

options = {
  "Authorization" => "Bearer #{token}",
  "accept" => "application/json"
}

response = URI.open(url, options).read
genre_response = URI.open(genre_url, options).read
data = JSON.parse(response)
genre_data = JSON.parse(genre_response)
puts data["results"].length

genres = genre_data["genres"].to_h do |genre|
  [ genre["id"], genre["name"] ]
end

data["results"].each do |movie|
  next if movie["overview"].blank? || movie["genre_ids"].blank?

  puts movie["genre_ids"].inspect

    Movie.create!(
    title: movie["title"],
    year: movie["release_date"].to_s[0..3],
    synopsis: movie["overview"],
    genre: movie["genre_ids"].map { |id| genres[id] }.join(", "),
    poster_url: "https://image.tmdb.org/t/p/w500#{movie["poster_path"]}",
    # rating: movie["vote_average"]
    # providers: movie["with_watch_provider"]
  )
end
