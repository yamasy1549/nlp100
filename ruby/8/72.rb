require './util'

words, bows = bag_of_words

puts words.join(',')
bows.each { |bow| puts bow.join(',') }
