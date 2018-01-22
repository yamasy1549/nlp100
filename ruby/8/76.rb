require './util'
require './train'

model_file = 'models/73.pkl'
if File.exist?(model_file)
  model = joblib.load(model_file)
else
  model = logreg(x_train, y_train)
  joblib.dump(model, model_file)
end

x_train, _, y_train, _ = train_test_data

[model.predict_proba(x_train).tolist.to_a, y_train].transpose.each do |probability, label|
  prob_label = (probability[0] >= probability[1]) ? '+1' : '-1'
  puts "#{label}\t#{prob_label}\t#{probability.max}"
end
