require './util'

redis = Redis.new(host: '127.0.0.1', port: 6379, db: 0)

japanese_artists_count = redis.keys.map{ |artist| redis.search(artist).count('Japan') }.sum
puts japanese_artists_count
