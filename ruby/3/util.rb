require 'zlib'
require 'json'

def gzip2hash(filename="../../python/3/jawiki-country.json.gz")
  articles = {}
  gzip = Zlib::GzipReader.open(filename)
  gzip.each_line do |line|
    article = JSON.parse(line)
    articles[article["title"]] = article["text"]
  end
  gzip.close

  articles
end

def raw_template_to_hash(article)
  templates = {}
  raw_template = article.slice(/^\{{2}基礎情報.*?$\n([\s\S]+)^\}{2}$/m, 1)
  raw_template.scan(/\|(?<key>.+?)\s*=\s*(?<val>.+?)(?:(?=\n$)|(?=\n\|))/m) do |key, val|
    templates[key] = block_given? ? yield(val) : val
  end

  templates
end

class String
  def remove_emphasis
    self.gsub(
      /(?<emphasis>'{5}|'{3}|'{2})(?<content>.*?)\k<emphasis>/,
      '\k<content>'
    )
  end

  def remove_fileinfo
    self.gsub(
      /(?:ファイル|File):(?<filename>.+?)\|/,
      '\k<filename>'
    )
  end

  def remove_innerlink
    self.gsub(
      /\[{2}(?:[^|]*?\|?)?(?<link>[^|]*?)\]{2}/,
      '\k<link>'
    )
  end

  def remove_link
    self.gsub(
      /\[\S+\s(?<title>[^\[\]]+)\]/,
      '\k<title>'
    )
  end

  def remove_tag
    self.gsub(
      /\<(?:[^\<\>])+\>/,
      ''
    )
  end

  def remove_template
    self.gsub(
      /\{{2}(?:.*)\|(?<lang_text>.*)\}{2}/,
      '\k<lang_text>'
    )
  end
end
