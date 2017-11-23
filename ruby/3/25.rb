require './util'

article = gzip2hash["イギリス"]
hash = raw_template_to_hash(article)

hash.sort.to_h.each do |key, val|
  puts [key, val].join(" ")
end
