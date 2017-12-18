require './util'

dependencies.each do |sentence|
  sentence.each do |chunk|
    if chunk.depends? && chunk.has_pos?("名詞")
      path = chunk.path_to_root(sentence).map(&:surfaces)
      puts path.join(" -> ") unless path[-1].blank?
    end
  end
end
