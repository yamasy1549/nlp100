require './util'

include WordVector

word_sims = {}
calc_vec = vec('Spain') - vec('Madrid') + vec('Athens')

progressbar = ProgressBar.create(total: @@dict_t_keys.size)

@@dict_t_keys.each do |word|
  word_vec = vec(word)
  word_sims[word] = cossim(calc_vec, word_vec)
  progressbar.increment
end

progressbar.finish

word_sims.sort_by_value.take(20).each do |word, sim|
  puts "#{word}\t#{sim}"
end
