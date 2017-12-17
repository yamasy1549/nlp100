require './util'

dependencies.each do |sentence|
  sentence.each do |chunk|
    if chunk.depends? && !chunk.surfaces.empty? && !sentence[chunk.dst].surfaces.empty? \
      && chunk.poss.include?("名詞") && sentence[chunk.dst].poss.include?("動詞")
      puts "#{chunk.surfaces}\t#{sentence[chunk.dst].surfaces}"
    end
  end
end
