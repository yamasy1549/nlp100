require 'pry'
require 'lingua/stemmer'
require 'ruby-progressbar'

STEMMER = Lingua::Stemmer.new(language: 'en')

# https://raw.githubusercontent.com/Alir3z4/stop-words/0e438af98a88812ccc245cf31f93644709e70370/english.txt
STOPWORDS = File.open('../../data/stop-words.txt') { |file| file.read.split("\n") }

class String
  def stopword?(stopwords: STOPWORDS)
    stopwords.include?(self.downcase)
  end

  def word_freqs
    word_groups = self.split.group_by do |word|
      STEMMER.stem(word) unless word.stopword? || word.match?(/[[:^alpha:]]/)
    end
    word_groups.map{ |key, words| [key, words.count] }.to_h.reject{ |key, _| key.nil? }
  end
end

def word_freqs(filename: '../../data/sentiment.txt', sentences: nil)
  freqs = []

  if sentences
    progressbar = ProgressBar.create(title: 'Freqs', total: sentences.count)
    freqs = sentences.map do |sentence|
      progressbar.increment
      sentence.word_freqs
    end
  else
    progressbar = ProgressBar.create(title: 'Freqs', total: `wc -l #{filename}`.to_i)
    File.open(filename) do |file|
      file.each_slice(1000) do |chunk|
        freqs += chunk.map do |line|
          progressbar.increment
          line.scrub('?').chomp[3...-1].word_freqs
        end
      end
    end
  end

  progressbar.finish
  freqs
end

def bag_of_words(at_least: 3)
  freqs = word_freqs
  words = freqs.map(&:keys).flatten.uniq
  bow = words.product([0]).to_h

  # 単語の出現回数がat_least回以上のものだけ
  freqs.each do |freq|
    bow.merge!(freq) { |_, v0, v1| v0 + v1 }
  end
  words = bow.select{ |_, count| count >= at_least }.keys
  bow = words.product([0]).to_h

  if block_given?
    yield(words, freqs, bow)
  else
    progressbar = ProgressBar.create(title: 'Bows', total: freqs.count)
    bows = freqs.map do |freq|
      progressbar.increment
      useful_freq = freq.select { |key, _| bow[key] }
      bow.merge(useful_freq){ |key, v0, v1| v0 + v1 }.values
    end
    progressbar.finish

    return words, bows
  end
end
