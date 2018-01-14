require 'pry'
require 'zlib'
require 'json'
require 'redis'
require 'mongo'
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

def mongo_init
  Mongo::Logger.logger.level = Logger::FATAL
  client = Mongo::Client.new(['127.0.0.1:27017'], database: '64')
  client[:artists]
end
