require 'uri'
require 'open-uri'
require 'json'
require './util'

article = gzip2hash["イギリス"]
hash = raw_template_to_hash(article) do |val|
  val.remove_emphasis
    .remove_fileinfo
    .remove_innerlink
    .remove_link
    .remove_tag
    .remove_template
end

filename = hash["国旗画像"]
wikipedia_api = "http://ja.wikipedia.org/w/api.php?"
params = {
  action:        "query",
  titles:        "Image:" + filename,
  prop:          "imageinfo",
  iiprop:        "url",
  format:        "json",
  formatversion: "2"
}

begin
  uri = URI.parse(wikipedia_api)
  uri.query = URI.encode_www_form(params)
  json_res = JSON.parse(uri.open.read)
  puts json_res['query']['pages'][0]['imageinfo'][0]['url']
rescue => e
  puts e
end
