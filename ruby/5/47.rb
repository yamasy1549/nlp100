require './util'

dependencies.each do |sentence|
  sentence.each do |chunk|
    next unless chunk.has_sahen_wo? && chunk.depends?
    dst = sentence[chunk.dst]
    verb = dst.first_morph("動詞")

    next unless verb
    # 述語（〜を〜）
    predicate = chunk.sahen_wo + verb.base

    src_pairs = []
    dst.srcs.each do |src|
      # 自分自身に係るものであれば除く
      next if sentence[src] == chunk
      src_chunk = sentence[src]
      src_particle = src_chunk.first_morph("助詞")&.surface
      src_pairs << [src_chunk.surfaces, src_particle] if src_chunk && src_particle
    end

    surfaces, particles = src_pairs.sort_by{ |_, particle| particle }.transpose
    puts [predicate, particles.join(' '), surfaces.join(' ')].join("\t") if particles.present?
  end
end
