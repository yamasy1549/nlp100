require './util'

dependencies.each do |sentence|
  sentence.each do |chunk|
    if chunk.depends? && chunk.surfaces.present? && sentence[chunk.dst].surfaces.present? \
      && chunk.has_pos?("名詞") && sentence[chunk.dst].has_pos?("動詞")
      puts [chunk.surfaces, sentence[chunk.dst].surfaces].join("\t")
    end
  end
end
