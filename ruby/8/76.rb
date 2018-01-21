require './util'
require './train'

x_train, _, y_train, _ = train_test_data
model = logreg(x_train, y_train)

[model.predict_proba(x_train).tolist.to_a, y_train].transpose.each do |probability, label|
  prob_label = (probability[0] >= probability[1]) ? '+1' : '-1'
  puts "#{label}\t#{prob_label}\t#{probability.max}"
end
