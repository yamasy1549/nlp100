require 'pry'
require 'ruby-progressbar'
require 'pycall/import'
include PyCall::Import

`export PYTHONPATH=/usr/local/lib/python2.7/site-packages`

pyfrom 'sklearn.model_selection', import: :train_test_split
pyfrom 'sklearn.linear_model', import: :LogisticRegression

def train_test_data(test_size: 0)
  labels = []
  File.open('../../data/sentiment.txt') do |file|
    labels = file.each_line.map { |line| line[0..1] }
  end

  _, bows = bag_of_words
  train_test_split(bows, labels, test_size: test_size)
end

def logreg(x_train, y_train)
  model = LogisticRegression.()
  model.fit(x_train, y_train)
  model
end
