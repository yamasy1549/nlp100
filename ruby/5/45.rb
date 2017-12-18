require './util'

dependencies.each do |sentence|
  sentence.each do |chunk|
    verb = chunk.first_morph("動詞")
    if verb
      predicate = verb.base
      particles = chunk.srcs.map { |src| sentence[src].first_morph("助詞")&.base }.compact

      puts [predicate, particles.sort.join(' ')].join("\t") if particles.present?
    end
  end
end
