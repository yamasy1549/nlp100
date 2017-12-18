require './util'

sentence = dependencies[2]

sentence.each do |chunk|
  chunk.morphs.each do |morph|
    puts "surface: #{morph.surface}, base: #{morph.base}, pos: #{morph.pos}, pos1: #{morph.pos1}"
  end
end
