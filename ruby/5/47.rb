require './util'

dependencies.each do |sentence|
  sentence.each do |chunk|
    if chunk.has_sahen_wo? && chunk.depends?
      dst = sentence[chunk.dst]
      verb = dst.morphs.find{ |chunk| chunk.pos == "動詞" }
      if verb
        predicate = chunk.sahen_wo + verb.base

        src_chunks = dst.srcs.map{ |src| sentence[src] }.reject{ |elem| elem == chunk }
        src_particles = src_chunks.map{ |chunk| chunk.morphs.reverse.find{ |morph| morph.pos == "助詞" }&.surface }
        src_pairs = src_chunks.map(&:surfaces).zip(src_particles).reject{ |chunk, particle| chunk.nil? || particle.nil? }
        src_pairs = src_pairs.sort_by{ |_surfaces, particle| particle }.transpose

        if src_pairs.present?
          puts "#{predicate}\t#{src_pairs[1].join(' ')}\t#{src_pairs[0].join(' ')}"
        end
      end
    end
  end
end
