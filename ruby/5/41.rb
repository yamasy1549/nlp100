require './util'

# "この書生というのは時々我々を捕えて煮て食うという話である。"
sentence = dependencies[7]

sentence.each do |chunk|
  puts "morphs: #{chunk.surfaces(symbol: true)}, dst: #{chunk.dst}, srcs: #{chunk.srcs.to_s}"
end
