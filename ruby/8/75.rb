require './util'
require './train'

model_file = 'models/73.pkl'
if File.exist?(model_file)
  model = joblib.load(model_file)
else
  x_train, _, y_train, _ = train_test_data
  model = logreg(x_train, y_train)
  joblib.dump(model, model_file)
end

origin_words = []
bag_of_words do |words, _, _|
  origin_words = words
end

weights = model.coef_.tolist.to_a[0]

puts 'Top10:'
weights.max(10).each.with_index(1) do |weight, i|
  puts "\t#{i}: #{origin_words[weights.index(weight)]}(#{weight})"
end

puts 'Worst10:'
weights.min(10).each.with_index(1) do |weight, i|
  puts "\t#{i}: #{origin_words[weights.index(weight)]}(#{weight})"
end
