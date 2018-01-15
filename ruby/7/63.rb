require './util'

redis = Redis.new(host: '127.0.0.1', port: 6379, db: 1)

unless redis.keys.present?
  open_gzip do |artist|
    redis.rpush(artist['name'], artist['tags'].to_json)
  end
end

redis.search('Oasis').each.with_index(1) do |tags, i|
  puts "No.#{i}"
  if tags = JSON.parse(tags)
    tags.each do |tag|
      puts "\t#{tag['value']}\t#{tag['count']}"
    end
  else
    puts "\tNo tag"
  end
end
