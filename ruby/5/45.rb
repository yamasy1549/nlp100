require './util'

dependencies.each do |sentence|
  sentence.each do |chunk|
    predicate = chunk.morphs.find { |morph| morph.pos == "動詞" }&.base
    if predicate && !chunk.surfaces.empty? && !sentence[chunk.dst].surfaces.empty?
      particle_cases = chunk.srcs.map do |src|
        sentence[src].morphs.find { |morph| morph.pos == "助詞" }&.base
      end
      puts "#{predicate}\t#{particle_cases.compact.sort.join(' ')}" if particle_cases.compact.present?
    end
  end
end
