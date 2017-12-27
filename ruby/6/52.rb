require './util'
require 'stemmify'

filename = '../../output/51.txt'

File.open(filename) do |words|
  words.each do |word|
    puts "#{word.chomp}\t#{word.chomp.stem}"
  end
end
