require './util'

x_train, x_test, y_train, y_test = train_test_data
model = logreg(x_train, y_train)

puts "train: #{model.score(x_train, y_train)}"
puts "test: #{model.score(x_test, y_test)}"
