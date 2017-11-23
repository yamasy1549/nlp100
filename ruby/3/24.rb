require './util'

article = gzip2hash["イギリス"]

puts article.scan(/(?:ファイル|File):(.+?)\|/)
