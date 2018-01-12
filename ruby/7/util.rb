require 'pry'
require 'zlib'
require 'json'
require 'redis'
require 'active_record'

def open_gzip(filename: '../../data/artist.json.gz')
  Zlib::GzipReader.open(filename) do |lines|
    lines.each do |line|
      artist = JSON.parse(line)
      yield(artist)
    end
  end
end

class Redis
  def search(name)
    self.lrange(name, 0, -1)
  end
end
