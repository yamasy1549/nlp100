require './util'

article = gzip2hash["イギリス"]
hash = raw_template_to_hash(article) do |val|
  val.remove_emphasis
    .remove_fileinfo
    .remove_innerlink
end

hash.sort.to_h.each do |key, val|
  puts [key, val].join(" ")
end
