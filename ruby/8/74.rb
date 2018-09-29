require './util'
require './train'

model_file = '73.pkl'
if File.exist?(model_file)
  model = joblib.load(model_file)
else
  x_train, _, y_train, _ = train_test_data
  model = logreg(x_train, y_train)
  joblib.dump(model, model_file)
end

sentences = [
  'It is too bad to pay for nothing .',
  'It was very good ! I love it .'
]

freqs = word_freqs(sentences: sentences)

bows = []
bag_of_words do |words, _, bow|
  bows = freqs.map do |freq|
    freq_bow = bow.clone
    freq.each do |word, count|
      freq_bow[word] += count if words.include?(word)
    end
    freq_bow.values
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
