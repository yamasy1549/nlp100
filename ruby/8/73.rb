require './util'
require './train'

x_train, _, y_train, _ = train_test_data
model = logreg(x_train, y_train)

puts "accuracy(train)\t#{model.score(x_train, y_train)}"
