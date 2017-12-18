require './util'

dependencies.each do |sentence|
  sentence.each do |chunk|
    if chunk.has_sahen_wo? && chunk.depends?
      dst = sentence[chunk.dst]
      verb = dst.first_morph("動詞")
      if verb
        predicate = chunk.sahen_wo + verb.base

        src_chunks = dst.srcs.map { |src| sentence[src] unless sentence[src] == chunk }.compact
        src_particles = src_chunks.map { |chunk| chunk.first_morph("助詞")&.surface }.compact
        if src_chunks.size == src_particles.size
          src_pairs = src_chunks.map(&:surfaces).zip(src_particles)
          surfaces, particles = src_pairs.sort_by{ |_, particle| particle }.transpose

          puts [predicate, particles.join(' '), surfaces.join(' ')].join("\t") if particles.present?
        end
      end
    end
  end
end
