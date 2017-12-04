require './util'

long_nouns = []

morphologies.each do |sentence|
  nouns = []
  sentence.each do |pos:, surface:, **|
    if pos == "名詞"
      nouns << surface
    else
      long_nouns << nouns if nouns.length > 1
      nouns = []
    end
  end
end

puts long_nouns.map(&:join)
