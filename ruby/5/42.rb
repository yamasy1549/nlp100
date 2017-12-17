require './util'

dependencies.each do |sentence|
  sentence.each do |chunk|
    if chunk.depends? && !chunk.surfaces.empty? && !sentence[chunk.dst].surfaces.empty?
      puts "#{chunk.surfaces}\t#{sentence[chunk.dst].surfaces}"
    end
  end
end
