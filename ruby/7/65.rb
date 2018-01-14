require './util'

collection = mongo_init

puts collection.find({ name: 'Queen' }).to_a
