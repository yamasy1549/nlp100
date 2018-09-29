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

words = bag_of_words { |words, _, _| words }

weights = model.coef_.tolist.to_a[0]

puts 'Top10:'
weights.max(10).each.with_index(1) do |weight, i|
  puts "\t#{i}: #{words[weights.index(weight)]}\t(#{weight})"
end

puts 'Worst10:'
weights.min(10).each.with_index(1) do |weight, i|
  puts "\t#{i}: #{words[weights.index(weight)]}\t(#{weight})"
end
