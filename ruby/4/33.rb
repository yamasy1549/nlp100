require './util'

morphologies.each do |sentence|
  sentence.each do |surface:, pos:, pos1:, **|
    puts surface if pos == "名詞" && pos1 == "サ変接続"
  end
end
