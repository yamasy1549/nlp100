require './util'

sentence = dependencies[2]
sentence.each do |chunk|
  chunk.morphs.each do |morph|
    puts [morph.surface, morph.base, morph.pos, morph.pos1].join(" ")
  end
end
