require './util'

morphologies.each do |sentence|
  sentence.ngram(3).each do |(first, second, third)|
    if second[:surface] == "の" && first[:pos] == "名詞" && third[:pos] == "名詞"
      puts [first, second, third].map(&->word { word[:surface] }).join
    end
  end
end
