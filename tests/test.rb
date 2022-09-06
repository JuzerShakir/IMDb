require_relative 'collect_data.rb'
include IMDb

movie1 = CollectData.new("https://www.imdb.com/title/tt7466810/?ref_=wl_li_tt")
movie2 = CollectData.new("https://www.imdb.com/title/tt0111161/")
# movie = CollectData.new("https://www.imdb.com/title/tt5491994/?ref_=tt_ov_inf")

# not supported
# movie = CollectData.new("https://www.imdb.com/title/tt6142646/?ref_=ttep_ep1")
# movie = CollectData.new("https://www.imdb.com/title/tt4351260/?ref_=ttep_ep1")
# movie = CollectData.new("https://www.imdb.com/title/tt6161168/?ref_=adv_li_tt")
# movie = CollectData.new("kfdf")

# p movie1.url
# p movie.error_message
# p movie.errors
# p movie2.title
# p movie1.ratings
# p movie2.type
# p movie1.director
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