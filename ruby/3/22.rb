require './util'

article = gzip2hash["イギリス"]

puts article.scan(/\[{2}Category:(.+?)(?:\|.*)*\]{2}/)

# String#scan(pattern) -> Array
# patternとマッチする部分を文字列から全て取り出し、配列の要素として返す
#
# 正規表現オブジェクト
# /pattern/ == %r(pattern)
