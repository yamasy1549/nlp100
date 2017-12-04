require './util'

freqs = morphologies.word_freq
freqs.sort_by{ |word, count| [-count, word] }.each do |word, count|
  puts "#{word} #{count}"
end
