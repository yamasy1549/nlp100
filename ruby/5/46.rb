require './util'

dependencies.each do |sentence|
  sentence.each do |chunk|
    predicate = chunk.morphs.find { |morph| morph.pos == "動詞" }&.base
    if predicate && !chunk.surfaces.empty? && !sentence[chunk.dst].surfaces.empty?
      particle_cases = chunk.srcs.map do |src|
        sentence[src].morphs.find { |morph| morph.pos == "助詞" }&.base
      end

      chunks = chunk.srcs.map do |src|
        sentence[src].surfaces
      end

      puts "#{predicate}\t#{particle_cases.join(' ')}\t#{chunks.join(' ')}" unless particle_cases.empty?
    end
  end
end
