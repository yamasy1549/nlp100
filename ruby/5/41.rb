require './util'

sentence = dependencies[7]
sentence.each do |chunk|
  puts "#{chunk.morphs.map(&:surface).join} #{chunk.dst}"
end
