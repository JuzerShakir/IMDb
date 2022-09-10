require_relative '../initiate_movie_tv.rb'
include IMDb

movie = IMDb::InitiateMovieTV.new("https://www.imdb.com/title/tt7466810/?ref_=wl_li_tt")
# movie = IMDb::InitiateMovieTV.new("https://www.imdb.com/title/tt0111161/")
# movie = IMDb::InitiateMovieTV.new("https://www.imdb.com/title/tt5491994/?ref_=tt_ov_inf")

# not supported
# movie = IMDb::InitiateMovieTV.new("https://www.imdb.com/title/tt6142646/?ref_=ttep_ep1")
# movie = IMDb::InitiateMovieTV.new("https://www.imdb.com/title/tt4351260/?ref_=ttep_ep1")
# movie = IMDb::InitiateMovieTV.new("https://www.imdb.com/title/tt6161168/?ref_=adv_li_tt")
# movie = IMDb::InitiateMovieTV.new("kfdf")

p movie.methods
# p movie.imdb_id
# p movie.url
# p movie.error_messages
# p movie.session_closed
# p movie.close_connection
# p movie.title
# p movie.ratings
# p movie.type
# p movie.director
# p movie.runtime
# p movie.release_date
# p movie.budget
# p movie.revenue
# p movie.genres
# p movie.produced_by
# p movie.tagline
# p movie.story
# p movie.casts
# p movie.popularity