require './util'

dependencies.each do |sentence|
  sentence.each do |chunk|
    verb = chunk.first_morph("動詞")
    if verb
      predicate = verb.base
      particles = chunk.srcs.map { |src| sentence[src].first_morph("助詞")&.base }.compact
      chunks = chunk.srcs.map { |src| sentence[src].surfaces if sentence[src].first_morph("助詞") }.compact
      particles, chunks = particles.zip(chunks).sort do |a, b|
        # 同じ助詞なら文節でもソート
        (a.first <=> b.first).nonzero? || (a.last <=> b.last)
      end.transpose

      puts [predicate, particles.join(' '), chunks.join(' ')].join("\t") if particles.present?
    end
  end
end
