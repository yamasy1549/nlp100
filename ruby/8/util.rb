require 'lingua/stemmer'
require 'ruby-progressbar'

STEMMER = Lingua::Stemmer.new(language: 'en')

# https://raw.githubusercontent.com/Alir3z4/stop-words/0e438af98a88812ccc245cf31f93644709e70370/english.txt
STOPWORDS = File.open('../../data/stop-words.txt') { |file| file.read.split("\n") }

class String
  def stopword?(stopwords: STOPWORDS)
    stopwords.include?(self.downcase)
  end

  def use_as_feature?
    !self.stopword? && !self.match?(/[[:^alpha:]]/)
  end

  def to_word_freqs
    freqs = {}

    self.split.each do |word|
      if word.use_as_feature?
        stemmed_word = STEMMER.stem(word)
        freqs[stemmed_word] ||= 0
        freqs[stemmed_word] += 1
      end
    end

    freqs
  end
end

def word_freqs(filename: '../../data/sentiment.txt', sentences: nil)
  freqs = []

  if sentences
    progressbar = ProgressBar.create(title: 'Freqs', total: sentences.count)
    freqs = sentences.map do |sentence|
      progressbar.increment
      sentence.to_word_freqs
    end
  else
    progressbar = ProgressBar.create(title: 'Freqs', total: `wc -l #{filename}`.to_i)
    File.open(filename) do |file|
      freqs = file.map do |line|
        progressbar.increment
        line.scrub('?').chomp[3...-1].to_word_freqs
      end
    end
  end

  progressbar.finish
  freqs
end

def bag_of_words(at_least: 3)
  freqs = word_freqs
  _bow = {}

  freqs.each do |freq|
    freq.each do |word, count|
      _bow[word] ||= 0
      _bow[word] += count
    end
  end

  # 単語の出現回数がat_least回以上のものだけ
  words = _bow.select{ |_, count| count >= at_least }.keys
  bow = words.product([0]).to_h

  if block_given?
    yield(words, freqs, bow)
  else
    progressbar = ProgressBar.create(title: 'Bows', total: freqs.count)
    bows = freqs.map do |freq|
      progressbar.increment
      freq_bow = bow.clone
      freq.each do |word, count|
        freq_bow[word] += count if words.include?(word)
      end
      freq_bow.values
    end
    progressbar.finish

    return words, bows
  end
end
