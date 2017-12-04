require './util'

morphologies.each do |sentence|
  sentence.each do |base:, pos:, **|
    puts base if pos == "動詞"
  end
end
