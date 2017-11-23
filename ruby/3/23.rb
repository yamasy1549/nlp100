require './util'

article = gzip2hash["イギリス"]

article.scan(/(?<level>={2,})\s?(?<name>.*?)\s?(?:\k<level>)/).each do |level, name|
  puts [level.length-1, name].join(" ")
end
