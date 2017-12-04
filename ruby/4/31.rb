require './util'

morphologies.each do |sentence|
  sentence.each do |surface:, pos:, **|
    puts surface if pos == "動詞"
  end
end
