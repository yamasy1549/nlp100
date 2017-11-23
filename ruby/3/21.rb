require './util'

article = gzip2hash["イギリス"]

article.each_line do |line|
  puts line if line.include?("Category")
end
