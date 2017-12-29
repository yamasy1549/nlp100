filename = "../../data/hightemp.txt"

lines = File.readlines(filename)
lines.each do |line|
  puts line.gsub("\t", " ")
end

# String#gsub(pattern, replace) -> String
# patternにマッチする部分全てをreplaceで置き換えた文字列を生成して返す
