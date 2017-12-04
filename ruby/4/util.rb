require 'pry'

def morphologies(filename="../../python/4/neko.txt.mecab")
  sentence_list = []

  File.open(filename) do |lines|
    sentence = []
    lines.each do |line|
      if line == "EOS\n"
        unless sentence.empty?
          sentence_list << sentence
          sentence = []
        end
      else
        elements = line.split(/[,\t]/)
        word = {
          surface: elements[0],
          base: elements[7],
          pos: elements[1],
          pos1: elements[2]
        }
        sentence << word
      end
    end
  end

  sentence_list
end

class Array
  def ngram(n)
    self.each_cons(n).select { |gram| gram.size == n }
  end

  def word_freq
    words = self.flatten
    words.group_by{ |surface:, **| surface }.map{ |k, v| [k, v.count] }.to_h
  end
end
