require './util'

collection = mongo_init

puts collection.find({ 'aliases.name': 'オアシス' }).to_a
