require './util'

include Word2Vec

family_analogy_file_name = '../../output/91.txt'
File.open('../../output/92.txt', 'w') do |output_file|
  File.open(family_analogy_file_name) do |file|
    file.each.with_index do |line, i|
      words = line.chomp
      word1, word2, word3, _ = words.split
      begin
        base_vec = vec(word2) - vec(word1) + vec(word3)
        most_similar(base_vec, [word1, word2, word3], 1).each do |word, sim|
          puts "#{i}: #{words} #{word} #{sim}"
          output_file.puts "#{words} #{word} #{sim}"
        end
      rescue => error
        puts "#{i}: #{words} -1"
        output_file.puts "#{words} -1"
      end
    end
  end
end
