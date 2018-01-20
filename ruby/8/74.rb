require './util'

x_train, x_test, y_train, y_test = train_test_data
model = logreg(x_train, y_train)

sentences = [
  'It is too bad to pay for nothing .',
  'It was very good ! I love it.'
]

stemmer = Lingua::Stemmer.new(language: 'en')
freqs = sentences.map do |sentence|
  freq = Hash.new(0)
  sentence.split.each do |word|
    freq[stemmer.stem(word)] += 1 unless word.stopword? || word.match?(/[[:^alpha:]]/)
  end
  freq
end

bows = []
bag_of_words do |words, _, bow|
  bows = freqs.map do |freq|
    clone_bow = bow.clone
    freq.each { |key, count| clone_bow[key] += count if clone_bow[key] }
    clone_bow.values
  end
end

model.predict_proba(bows).tolist.to_a.each.with_index do |probability, i|
  if probability[0] >= probability[1]
    puts "[+1]\t#{probability[0]}"
  else
    puts "[-1]\t#{probability[1]}"
  end
  puts "\t#{sentences[i]}"
end
