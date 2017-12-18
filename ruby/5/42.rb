require './util'

dependencies.each do |sentence|
  sentence.each do |chunk|
    if chunk.depends? && chunk.surfaces.present? && sentence[chunk.dst].surfaces.present?
      puts [chunk.surfaces, sentence[chunk.dst].surfaces].join("\t")
    end
  end
end
