require './util'
require 'lingua/stemmer'

stemmer = Lingua::Stemmer.new(language: 'en')

filename = '../../output/51.txt'

File.open(filename) do |words|
  words.each do |word|
    target = word.chomp
    if target.present?
      puts "#{target}\t#{stemmer.stem(target)}"
    else
      puts
    end
  end
end
