require './util'

collection = mongo_init

collection.indexes.create_many([
  { key: { name: 1 } },
  { key: { 'aliases.name': 1 } },
  { key: { 'tags.value': 1 } },
  { key: { 'rating.value': 1 } }
])

open_gzip do |artist|
  collection.insert_one(artist)
end
