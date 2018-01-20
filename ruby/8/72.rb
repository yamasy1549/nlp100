require './util'

File.open('../../data/sentiment_bows.txt', 'w') do |file|
  words, bows = bag_of_words
  file.puts words.join(',')
  bows.each do |bow|
    file.puts bow.join(',')
  end
end
