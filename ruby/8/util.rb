require 'pry'
require 'open-uri'
require 'lingua/stemmer'
require 'ruby-progressbar'
require 'pycall/import'
include PyCall::Import

`export PYTHONPATH=/usr/local/lib/python2.7/site-packages`

stopword_file = 'https://raw.githubusercontent.com/Alir3z4/stop-words/0e438af98a88812ccc245cf31f93644709e70370/english.txt'
STOPWORDS = open(stopword_file) { |file| file.read.split("\n") }

class String
  def stopword?(stopwords: STOPWORDS)
    stopwords.include?(self.downcase)
  end
end

def word_freqs(filename: '../../data/sentiment.txt')
  stemmer = Lingua::Stemmer.new(language: 'en')

  freqs = []
  progressbar = ProgressBar.create(title: 'Freqs', total: `wc -l #{filename}`.to_i)
  File.open(filename) do |lines|
    freqs = lines.map do |line|
      progressbar.increment
      freq = Hash.new(0)
      line.scrub('?').chomp[3...-1].split.each do |word|
        freq[stemmer.stem(word)] += 1 unless word.stopword? || word.match?(/[[:^alpha:]]/)
      end
      freq
    end
  end
  progressbar.finish
  freqs
end

def bag_of_words(at_least: 2)
  freqs = word_freqs
  words = freqs.map(&:keys).flatten.uniq
  bow = [words, Array.new(words.count, 0)].transpose.to_h

  # 単語の出現回数が1回以下のものはbowから省く
  freqs.each do |freq|
    bow.merge!(freq) { |_, v0, v1| v0 + v1 }
  end
  words = bow.select{ |word, count| count >= at_least }.keys
  bow = [words, Array.new(words.count, 0)].transpose.to_h

  if block_given?
    yield(words, freqs, bow)
  else
    progressbar = ProgressBar.create(title: 'Bows', total: freqs.count)
    bows = freqs.map do |freq|
      progressbar.increment
      clone_bow = bow.clone
      freq.each { |key, count| clone_bow[key] += count if clone_bow[key] }
      clone_bow.values
    end
    progressbar.finish

    return words, bows
  end
end

def train_test_data(test_size: 0.1)
  pyfrom 'sklearn.model_selection', import: :train_test_split

  labels = []
  labels_file = '../../data/sentiment.txt'
  File.open(labels_file) do |file|
    labels = file.each_line.map { |line| line[0..1] }
  end

  _, bows = bag_of_words

  return train_test_split(
    bows,
    labels,
    test_size: test_size
  )
end

def logreg(x_train, y_train)
  pyfrom 'sklearn.externals', import: :joblib
  filename = 'model.pkl'

  if File.exist?(filename)
    model = joblib.load(filename)
  else
    pyfrom 'sklearn.linear_model', import: :LogisticRegression
    model = LogisticRegression.()
    model.fit(x_train, y_train)
    joblib.dump(model, filename, compress=9)
  end
  model
end
