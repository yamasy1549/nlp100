require './util'

include Word2Vec

base_vec = vec("England")

most_similar(base_vec, %w(England), 10).each do |word, sim|
  puts "#{word}\t#{sim}"
end
