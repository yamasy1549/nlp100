require './util'

collection = mongo_init

top_artists = collection.find({ 'tags.value': 'dance' }).sort({ 'rating.count': -1 }).take(10)

top_artists.each.with_index(1) do |artist, i|
  puts "#{i}\t#{artist['name']}"
end
