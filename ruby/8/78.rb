require './util'
pyfrom 'sklearn.model_selection', import: 'KFold'
pyfrom 'sklearn.linear_model', import: :LogisticRegression
pyfrom 'sklearn.metrics', import: %i(precision_score recall_score f1_score)

bows, _, labels, _ = train_test_data

model = LogisticRegression.()

n_splits = 5
kf = KFold.(n_splits: n_splits, shuffle: true)
gen = kf.split(bows)

scores = n_splits.times.map do
  train, test = gen.next().to_a
  train_start, train_endd = train[0].to_i, train[-1].to_i
  test_start, test_endd = test[0].to_i, test[-1].to_i
  x_train, y_train = bows[train_start..train_endd], labels[train_start..train_endd]
  x_test, y_test = bows[test_start..test_endd], labels[test_start..test_endd]

  model.fit(x_train, y_train)
  y_pred = model.predict(x_test)
  {
    accuracy: model.score(x_test, y_test),
    precision: precision_score(y_test, y_pred, average: :macro),
    recall: recall_score(y_test, y_pred, average: :macro),
    f1: f1_score(y_test, y_pred, average: :macro)
  }
end

scores.first.keys.each do |key|
  puts "#{key}\t#{scores.sum{|hash| hash[key] } / scores.count}"
end
