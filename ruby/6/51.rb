require './util'

filename = '../../output/50.txt'

File.open(filename) do |sentences|
  sentences.each do |sentence|
    puts sentence.split
    puts
  end
end
