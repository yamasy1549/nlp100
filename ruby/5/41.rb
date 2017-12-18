require './util'

sentence = dependencies[7]

sentence.each do |chunk|
  puts "morphs: #{chunk.surfaces}, dst: #{chunk.dst}, srcs: #{chunk.srcs.to_s}"
end
