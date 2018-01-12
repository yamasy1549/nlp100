require './util'

redis = Redis.new(host: '127.0.0.1', port: 6379, db: 0)

unless redis.keys.present?
  open_gzip do |artist|
    redis.rpush(artist['name'], artist['area'])
  end
end
