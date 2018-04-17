require './util'

include Word2Vec

base_vec = vec("Spain") - vec("Madrid") + vec("Athens")

most_similar(base_vec, %w(Spain Madrid Athens), 10).each do |word, sim|
  puts "#{word}\t#{sim}"
end
