require './util'

dependencies.each do |sentence|
  noun_pairs = sentence.select { |chunk| chunk.has_pos?("名詞") }.combination(2)

  noun_pairs.each do |i, j|
    noun_i = i.first_morph("名詞")
    noun_j = j.first_morph("名詞")
    surface_i = noun_i.surface
    surface_j = noun_j.surface
    noun_i.surface = "X"
    noun_j.surface = "Y"

    path_i = i.path_to_root(sentence)
    path_j = j.path_to_root(sentence)
    if path_i.include?(j)
      # 文節iから構文木の根に至る経路上に文節jが存在する場合
      puts path_i[0...path_i.index(j)].map(&:surfaces).push("Y").join(" -> ")
    else
      # 文節iと文節jから構文木の根に至る経路上で共通の文節kで交わる場合
      k = (path_i & path_j).first
      output_paths = [
        path_i[0...path_i.index(k)].map(&:surfaces).join(" -> "),
        path_j[0...path_j.index(k)].map(&:surfaces).join(" -> "),
        k.surfaces
      ]
      puts output_paths.join(" | ")
    end

    noun_i.surface = surface_i
    noun_j.surface = surface_j
  end
end
